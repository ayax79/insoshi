module AlbumsHelper

  def album_song_list_xml(album)
    url_for :controller => 'songs', :action => 'index', :format => 'xml', :album_id => album.id
  end
  
end
