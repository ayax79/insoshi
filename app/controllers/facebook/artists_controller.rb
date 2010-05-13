class Facebook::ArtistsController < ApplicationController
  layout "facebook"

  def show
    @owner_id = params[:fb_sig_profile_user]
    owner = Artist.find_by_facebook_id @owner_id
    if owner.nil?
      owner = Person.find_by_facebook_id @owner_id
    end

    respond_to do |format|
      unless owner.nil?
        if owner.is_a? Artist
          @artists = owner
          format.fbml
        elsif owner.is_a? Person
          @person = owner
          format.fbml { render "people_artists" }
        end
      else
        format.fbml { render "nocontent" }
      end
    end
  end

end
