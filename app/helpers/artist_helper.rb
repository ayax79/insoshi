module ArtistHelper
  def fan_link(person, artist)
    unless artist.member?(person) or
            artist.fan?(person)
      link_to 'Become a Fan', { :controller => 'artists', :action => 'fan', :id => artist }
    end
  end

  def artist_link_with_image(text, artist = nil, html_options = nil)
    if artist.nil?
      artist = text
      text = artist.name
    elsif artist.is_a?(Hash)
      html_options = artist
      artist = text
      text = artist.name
    end
    '<span class="imgHoverMarker">' + image_tag(artist.thumbnail) + artist_link_with_options(text, artist, html_options) + '</span>'
  end

  def artist_link_with_options(text, artist = nil, html_options = nil)
    if artist.nil?
      artist = text
      text = artist.name
    elsif artist.is_a?(Hash)
      html_options = artist
      artist = text
      text = artist.name
    end
    # We normally write link_to(..., artist) for brevity, but that breaks
    # activities_helper_spec due to an RSpec bug.
    link_to(h(text), artist, html_options)
  end
end

