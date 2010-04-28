class Facebook::ArtistsController < ApplicationController
  layout :facebook
  
  def show
    @artist = Artist.find(params[:id])

    respond_to do |format|
      format.fbml # show.fbml.erb
    end
  end

end
