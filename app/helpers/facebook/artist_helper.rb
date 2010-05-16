module Facebook::ArtistHelper

  def player_link(artist)
    %(<fb:swf swfsrc="#{swf_player_path}"
        height="200" width="295" swfbgcolor="FFFFFF"
        flashvars="#{player_flashvars(artist)}"/>)
  end

  def swf_player_path
    swf_path("playerMultipleList.swf")
  end

  def songs_link(artist)
    url_for :host => JAMFU_HOST, :controller => "facebook/artists", :action => "top_songs", :id => artist.id
  end

  def player_flashvars(artist)
    CGI::escape %(autoPlay=no&playlistPath=#{songs_link(artist)})
  end
  
end