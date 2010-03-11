module ArtistHelper
  def fan_link(person, artist)
    unless artist.is_member?(person) or
            artist.is_fan?(person)
      link_to 'Become a Fan', { :controller => 'artists', :action => 'fan', :id => artist }
    end
  end
end

