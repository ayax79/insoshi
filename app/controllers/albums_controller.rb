class AlbumsController < ApplicationController
  include SharedFilters

  before_filter :prepare_artist
  before_filter :require_member, :only => [:new, :create]


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
    @album = Album.new(:artist => @artist)

    respond_to do |format|
      format.html
    end
  end

  def create
    if params[:album].nil?
      flash[:error] = "Your browser doesn't appear to support file uploading"
      redirect_to artist_path @artist, :anchor => 'tAlbums' and return
    end
    album_data = params[:album].merge(:artist => @artist)
    @album = @artist.albums.build(album_data)

    respond_to do |format|
      if @album.save
        flash[:notice] = "Album created successfully"
        format.html { redirect_to(@artist, :anchor => "tAlbums")  }
      else
        format.html { render :action => 'new' }
      end
    end
  end


end
