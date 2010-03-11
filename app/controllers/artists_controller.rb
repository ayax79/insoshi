class ArtistsController < ApplicationController
  include ArtistHelper

  before_filter :login_required, :except => [:index, :show]
  before_filter :member_required, :only => [:edit, :update]

  def index
    @artists = Artist.paginate(:all, :page => params[:page], :order => :name)
    current_person

    respond_to do |format|
      format.html
    end
  end

  def show
    begin
      @artist = Artist.find_by_name(params[:id])
    rescue
      # fall back and try by id
    end

    # fallback to the Artist.id if the name was not passed in the url
    # artist_link should be used for rendering artist_urls
    @artist = Artist.find(params[:id]) unless @artist

    respond_to do |format|
      format.html
    end
  end

  def new
    @artist = Artist.new

    respond_to do |format|
      format.html
    end
  end

  def create
    @artist = Artist.new(params[:artist])
    add_invites

    respond_to do |format|
      if @artist.save
        @artist.members << ArtistMember.create!(:person => current_person, :artist => @artist) 
        format.html { redirect_to(@artist) }
      else
        format.html { render :action => 'new'}
      end
    end
  end

  def edit
    respond_to do |format|
      format.html
    end
  end

  def update
    add_invites
    respond_to do |format|
      if @artist.update_attributes(params[:artist])
        flash[:notice] = 'Artist was succesfully updated'
        format.html { redirect_to @artist }
      else
        format.html { render :action => :edit}
      end
    end

  end

  def fan
    @artist = Artist.find(params[:id])
    #noinspection RubyDuckType
    @artist.fans << current_person unless @artist.is_fan?(current_person)
    @artist.save
    respond_to do |format|
      format.html { redirect_to :action => 'show', :id => @artist }
    end
  end

  def accept_member_invite
    @invite = ArtistInvite.find(params[:id])
    @accept = params[:accept]
    @artist = @invite.artist
    @person = current_person

    if @invite.email == @person.email
      @invite.delete
      if @accept
        @artist.members << ArtistMember.create!(:person => @person, :artist => @artist)
        @artist.save!
        flash[:artist_invite] = "You have a successfully been added a member"
      else
        flash[:artist_invite] = "You have denied the membership request"
      end
    end

    respond_to do |format|
      if @accept
        format.html { redirect_to :action => 'show', :id => @artist}
      else
        format.html { redirect_to :home }
      end
    end

  end

  protected

  def add_invites
    addresses = params[:addresses]
    if addresses
      addresses.split.each do |email|
        @artist.artist_invites << ArtistInvite.new(:email => email, :artist => @artist)
      end
    end
  end

  def member_required
    @artist = Artist.find(params[:id])
    @artist.is_member? current_person
  end

end

