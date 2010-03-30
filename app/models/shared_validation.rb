module SharedValidation

  protected

  def person_or_artist_required
    if person_id.nil? and artist_id.nil?
      errors.add_to_base("Must have either a person_id or an artist_id")
    end
  end

end