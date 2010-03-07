module ArtistHelper

  def is_member(current_person, artist)
    !current_person and current_person.membered_artists.include? artist
  end

  def is_fan(current_person, artist)
    !current_person and current_person.fanned_artists.include? artist
  end

  def fan_link(current_person, artist)
    unless is_member(current_person, artist) or
            is_fan(current_person, artist)
      link_to 'Become a Fan', { :controller => 'artists', :action => 'fan', :id => artist }
    end
  end
end

