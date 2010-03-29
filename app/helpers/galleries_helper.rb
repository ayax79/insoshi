module GalleriesHelper

  def all_galleries_path(gallery)
    unless gallery.artist.nil?
      artist_path gallery.artist, :anchor => 'tGalleries'
    else
      person_path gallery.person, :anchor => 'tGalleries'
    end
  end

  def gallery_owner_link_with_image(gallery)
    unless gallery.artist.nil?
      artist_link_with_image(gallery.artist)
    else
      person_link_with_image(gallery.person)
    end
  end

  def gallery_owner_link(gallery)
    unless gallery.artist.nil?
      artist_link(gallery.artist)
    else
      person_link(gallery.person)
    end
  end

  def gallery_editable?(gallery)
    unless gallery.artist.nil?
      gallery.artist.member? current_person
    else
      current_person? person
    end
  end

  def new_photo_path_handle_artist(gallery)
    unless gallery.artist.nil?
      new_gallery_photo_path(@gallery, :artist_id => gallery.artist.id)
    else
      new_gallery_photo_path(@gallery)
    end
  end

  def edit_gallery_path_handle_artist(gallery)
    unless gallery.artist.nil?
      edit_gallery_path(:artist_id => gallery.artist.id)
    else
      edit_gallery_path
    end
  end

end
