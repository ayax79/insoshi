require 'spec_helper'

describe SongsController do

  integrate_views

  before(:each) do
    login_as(:quentin)

    @artist = mock(Artist)
    Artist.stub!(:find).and_return(@artist)
    @artist_id = 123123
    @artist.stub!(:id).and_return(@artist_id)
    @artist.stub!(:member?).and_return(true)

    @album = mock(Album)
    Album.stub!(:find).and_return(@album)
    @album_id = 322332
    @album.stub!(:id).and_return(@album_id)
    @album.stub!(:artist).and_return(@artist)
  end

  describe "index" do
    before(:each) do
      @filename = '/pathhere/blah.mp3'
      @song_title = "slkfjasdflkjasdf"

      @song = mock(Song)
      @song.stub!(:public_filename).and_return(@filename)
      @song.stub!(:title).and_return(@song_title)

      @album.stub!(:songs).and_return([ @song ])
    end

    it "should render xml on index call" do
      get :index, :album_id => @album.id, :format => 'xml'
      response.should be_success
      response.should render_template('songs/index.xml.builder')
    end
  end

  it "should render new" do
    get :new, :album_id => @album.id, :artist_id => @artist.id
    response.should be_success
    response.should render_template('songs/new.html.erb')
    assigns(:song).should_not be_nil
  end

end
