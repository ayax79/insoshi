module PhotosHelper
  
  def photo_id(photo)
    photo.label_from_filename.gsub(/ /,'').gsub(/\./, "_")
  end

  def photo_editable?(photo)
    unless photo.artist.nil?
      photo.artist.member? current_person
    else
      current_person?(photo.person)
    end
  end

end
