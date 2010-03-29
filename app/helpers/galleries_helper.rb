module GalleriesHelper

  def all_galleries_path(gallery)
    if gallery.is_a? Gallery
      unless gallery.artist.nil?
        artist_path gallery.artist, :anchor => 'tGalleries'
      else
        for_person gallery.person
      end
    elsif is_a? Person
      person_path gallery
    elsif is_a? Artist
      artist_path gallery
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

  private

  def for_person(person)
    person_path person, :anchor => 'tGalleries'
  end

  def for_artist(artist)
    artist_path artist, :anchor => 'tGalleries'
  end


end
