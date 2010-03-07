module ArtistHelper

  def is_member(person, artist)
    person and person.is_a? Person and person.membered_artists.include? artist
  end

  def is_fan(person, artist)
    person and person.is_a? Person and person.fanned_artists.include? artist
  end

  def fan_link(person, artist)
    unless is_member(person, artist) or
            is_fan(person, artist)
      link_to 'Become a Fan', { :controller => 'artists', :action => 'fan', :id => artist }
    end
  end
end

