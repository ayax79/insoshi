module GallerySharedFilters

  def artist_check
    unless params[:artist_id].nil?
      @artist = Artist.find(params[:artist_id])
      if @artist.nil? || !@artist.member?(current_person)
        flash[:error] = "You are not a member for that artist"
        redirect_to :home
        return
      end
    else
        @artist = nil
    end
  end

end