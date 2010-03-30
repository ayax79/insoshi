module GalleriesHelper

  def all_galleries_path(obj)
    if obj.is_a? Gallery
      unless obj.artist.nil?
        artist_path obj.artist, :anchor => 'tGalleries'
      else
        for_person obj.person
      end
    elsif obj.is_a? Person
      person_path obj, :anchor => 'tGalleries'
    elsif obj.is_a? Artist
      artist_path obj, :anchor => 'tGalleries'
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
      current_person? gallery.person
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
