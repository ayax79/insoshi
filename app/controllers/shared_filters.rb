module SharedFilters

  protected

  def prepare_artist
    artist_id = params[:artist_id]
    unless artist_id.nil?
      @artist = Artist.find(artist_id)
    end
  end

  def require_member_if_artist
    if !@artist.nil? and !@artist.member?(current_person)
      flash[:error] = "You are not a member for that artist"
      redirect_to :home
    end
  end

  def require_member
    artist_required
    
    if flash[:error].nil? and !@artist.member?(current_person)
      flash[:error] = "You are not a member for that artist"
      redirect_to :home
    end
  end

  def artist_required
    if @artist.nil?
      flash[:error] = "No artist was specified"
      redirect_to :home
    end
  end

end