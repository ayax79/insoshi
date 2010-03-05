class ArtistsController < ApplicationController

  def index
    @artists = Artist.all

    respond_to do |format|
      format.html
    end
  end

  def show
    @artist = Artist.find_by_name(params[:id])

    # fallback to the Artist.id if the name was not passed in the url
    # artist_link should be used for rendering artist_urls
    @artist = Artist.find(params[:id]) unless @artist

    respond_to do |format|
      format.html
    end
  end

end

