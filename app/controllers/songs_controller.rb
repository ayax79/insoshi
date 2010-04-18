class SongsController < ApplicationController

  include SharedFilters
  include ApplicationHelper

  before_filter :prepare_artist, :only => [:new, :create]
  before_filter :require_member, :only => [:new, :create]
  before_filter :album_required, :only => [:new, :create]

  def new
    @song = Song.new

    respond_to do |format|
      format.html
    end
  end

  def create
    if params[:song].nil?
      flash[:error] = "Your browser doesn't appear to support file uploading"
      redirect_to @album and return
    end
    album_data = params[:song].merge(:album => @album)
    @song = @album.songs.build(album_data)

    respond_to do |format|
      if @song.save
        flash[:success] = "Song Added"
        format.html { redirect_to album_path @album }
      else
        format.html { render :action => "new" }
      end
    end
  end

  protected

  def album_required
    @album = Album.find(params[:album_id])

    if @album.nil?
      flash[:error] = "No album was specified"
      redirect_to :home
    end
  end

end
