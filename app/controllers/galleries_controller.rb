class GalleriesController < ApplicationController
  
  include SharedFilters
  include GalleriesHelper

  before_filter :login_required
  before_filter :prepare_artist
  before_filter :require_member_if_artist, :only => [ :new, :create, :update, :destroy ]
  before_filter :correct_user_required, :only => [ :edit, :update, :destroy ]

  def show
    @body = "galleries"
    @gallery = Gallery.find(params[:id])
    @photos = @gallery.photos.paginate :page => params[:page]
  end

  def index
    @body = "galleries"
    @person = Person.find(params[:person_id])
    @galleries = @person.galleries.paginate :page => params[:page]
  end

  def new
    @gallery = Gallery.new
  end

  def create

    unless @artist.nil?
      @gallery = @artist.galleries.build(params[:gallery])
    else
      @gallery = current_person.galleries.build(params[:gallery])
    end

    respond_to do |format|
      if @gallery.save
        flash[:success] = "Gallery successfully created"
        format.html { redirect_to gallery_path(@gallery) }
      else
        format.html { render :action => "new" }
      end
    end
  end

  def edit
    @gallery = Gallery.find(params[:id])
    @artist = @gallery.artist
  end

  def update
    @gallery = Gallery.find(params[:id])
    respond_to do |format|
      if @gallery.update_attributes(params[:gallery])
        flash[:success] = "Gallery successfully updated"
        format.html { redirect_to gallery_path(@gallery) }
      else
        format.html { render :action => "new" }
      end
    end
  end

  def destroy
    if current_person.galleries.count == 1
      flash[:error] = "You can't delete the final gallery"
    elsif Gallery.find(params[:id]).destroy
      flash[:success] = "Gallery successfully deleted"
    else
      flash[:error] = "Gallery could not be deleted"
    end

    respond_to do |format|
      format.html { redirect_to all_galleries_path(@gallery) }
    end

  end

  private

  def correct_user_required
    @gallery = Gallery.find(params[:id])
    if @gallery.nil?
      flash[:error] = "No gallery found"
      redirect_to all_galleries_path(current_person)
    elsif (!@gallery.artist.nil? && !@gallery.artist.member?(current_person)) ||
            (!@gallery.person.nil? && @gallery.person != current_person)
      flash[:error] = "You are not the owner of this gallery"
      redirect_to all_galleries_path(@gallery)
    end
  end

end
