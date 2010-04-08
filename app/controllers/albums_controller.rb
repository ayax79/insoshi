class AlbumsController < ApplicationController
  include SharedValidation

  before_filter :person_or_artist_required, :only => [:new, :create]

  def index
    @albums = Album.paginate(:all, :page => params[:page], :order => :title)

    respond_to do |format|
      format.html
    end
  end

  def show
    @album = Album.find(params[:id])
    @artist = @album.artist

    respond_to do |format|
      format.html
    end
  end

  def new
    @album = Album.new
  end

  def create
    @album = Album.new(params[:album])

    respond_to do |format|
      format.html { redirect_to(:artist, :anchor => "tAlbums")  }
    end
  end

end
