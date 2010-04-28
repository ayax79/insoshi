# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  include AuthenticatedSystem
  include SharedHelper
  include PreferencesHelper

  filter_parameter_logging :password

  before_filter :create_page_view, :require_activation, :tracker_vars,
                :find_artist_invites

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => '71a8c82e6d248750397d166001c5e308'

  protected

  def admin_required
    unless current_person.admin?
      flash[:error] = "Admin access required"
      redirect_to home_url
    end
  end

  # Create a Scribd-style PageView.
  # See http://www.scribd.com/doc/49575/Scaling-Rails-Presentation
  def create_page_view
    # TODO - just chop the user agent for now, not really correct
    user_agent = request.env["HTTP_USER_AGENT"]
    user_agent = user_agent[0..254] if user_agent.length >= 255

    PageView.create(:person_id => session[:person_id],
                    :request_url => request.request_uri,
                    :ip_address => request.remote_ip,
                    :referer => request.env["HTTP_REFERER"],
                    :user_agent => user_agent)
    if logged_in?
      # last_logged_in_at actually captures site activity, so update it now.
      current_person.last_logged_in_at = Time.now
      current_person.save
    end
  end

  def require_activation
    if logged_in?
      unless current_person.active? or current_person.admin?
        redirect_to logout_url
      end
    end
  end

  # A tracker to tell us about the activity of Insoshi installs.
  def tracker_vars
    File.open("identifier", "w") do |f|
      f.write UUID.new
    end unless File.exist?("identifier")
    @tracker_id = File.open("identifier").read rescue nil
    @env = ENV['RAILS_ENV']
  end


  def find_artist_invites
    if logged_in?
      invites = ArtistInvite.find_all_by_email current_person.email
      unless invites.nil? or invites.empty?
        flash[:artist_invites] = invites
      end
    end
  end

  def rpx_setup
    unless Object.const_defined?(:RPX_API_KEY) && Object.const_defined?(:RPX_BASE_URL) && Object.const_defined?(:RPX_REALM)
      render :template => 'shared/const_message.html.erb'
      return false
    end
    @rpx = Rpx::RpxHelper.new(RPX_API_KEY, RPX_BASE_URL, RPX_REALM)
    return true
  end

end