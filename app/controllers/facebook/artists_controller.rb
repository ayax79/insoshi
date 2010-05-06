class Facebook::ArtistsController < ApplicationController
  layout :facebook
  
  def show
    #@artist = Artist.find(params[:id])

    @owner_id = params[:fb_sig_profile_user]

    respond_to do |format|
      format.fbml # show.fbml.erb
    end
  end

end
