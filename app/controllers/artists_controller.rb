class ArtistsController < ApplicationController

  before_filter :login_required, :except => [:index, :show]

  def index
    @artists = Artist.all

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
    @artist.members << current_person

    respond_to do |format|
      if @artist.save
        format.html { redirect_to(@artist) }
      else
        format.html { render :action => 'new'}
      end
    end
  end

end

