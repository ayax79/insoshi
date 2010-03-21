# This controller handles the login/logout function of the site.
class SessionsController < ApplicationController

  skip_before_filter :require_activation, :only => [:new, :destroy]
  skip_filter :verify_authenticity_token, :only => [:rpx_map_return, :rpx_return, :rpx_unmap] 
  before_filter :rpx_setup

  def new
    @body = "login single-col"
  end

  def create
    # Protect against bots hitting us.
    if params[:email].nil? or params[:password].nil?
      render :text => "" and return
    end
    password_authentication(params[:email], params[:password])
  end

  def failed_login(message = "Authentication failed.")
    @body = "login single-col"
    flash.now[:error] = message
    render :action => 'new'
  end

  def successful_login(message = "Logged in successfully")
    self.current_person = @person
    if params[:remember_me] == "1"
      current_person.remember_me
      cookies[:auth_token] = {
              :value => current_person.remember_token,
              :expires => current_person.remember_token_expires_at }
    end
    redirect_back_or_default('/')
    flash[:notice] = message
  end

  def password_authentication(login, password)
    person = Person.authenticate(login, password)
    unless person.nil?
      if person.deactivated?
        flash[:error] = "Your account has been deactivated"
        redirect_to home_url and return
      elsif global_prefs.email_verifications? and
              not person.email_verified? and not person.admin?
        flash[:notice] = %(Unverified email address. 
                           Please check your email for your activation code.)
        redirect_to login_url and return
      end
    end
    self.current_person = person
    if logged_in?
      # First admin logins should forward to preferences
      if current_person.last_logged_in_at.nil? and current_person.admin?
        @first_admin_login = true
      end
      current_person.last_logged_in_at = Time.now
      current_person.save!
      if params[:remember_me] == "1"
        current_person.remember_me
        cookies[:auth_token] = {
                :value => current_person.remember_token,
                :expires => current_person.remember_token_expires_at }
      end
      flash[:success] = "Logged in successfully"
      if @first_admin_login
        redirect_to admin_preferences_url
      else
        redirect_back_or_default('/')
      end
    else
      @body = "login single-col"
      flash.now[:error] = "Invalid email/password combination"
      params[:password] = nil
      render :action => 'new'
    end
  end

  def destroy
    current_person.forget_me if logged_in?
    cookies.delete :auth_token
    if logged_in? and current_person.deactivated?
      reset_session
      flash[:error] = "Your account is inactive."
      redirect_to login_url
    else
      reset_session
      flash[:success] = "You have been logged out."
      redirect_back_or_default(login_url)
    end
  end

  def rpx_return
    if params[:error]
      flash[:error] = "OpenID Authentication Failed: #{params[:error]}"
      redirect_to :login
      return
    end

    if !params[:token]
      flash[:notice] = "OpenID Authentication Cancelled"
      redirect_to :login
      return
    end

    data = @rpx.auth_info(params[:token], request.url)
    identifier = data["identifier"]

    person = nil
    begin
      cred = ExternalCred.find_by_identifier identifier
      person = cred.person unless cred.nil?
    rescue ActiveRecord::RecordNotFound
      # just ignore
    end

    if person.nil?
      flash[:error] = 'That login has not been tied to an account, would you like to register it?'
      session[:rpx_auth_info] = data
    else
      self.current_person = person
    end

    if logged_in?
      redirect_to :controller => 'home', :action => 'index'
    elsif session[:rpx_auth_info]
      redirect_to :signup
    else
      redirect_to :login # shouldn't really happen
    end

  end

end
