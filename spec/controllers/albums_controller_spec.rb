require 'spec_helper'

class AlbumThumbnail

  # Override full_filename to avoid writing files to the public image directory.
  # They go instead to Dir::tmpdir, which on *nix systems is usually /tmp.
  # See http://www.fngtps.com/2007/04/testing-with-attachment_fu for more info.
  def full_filename(thumbnail = nil)
    klass = thumbnail.nil? ? self : thumbnail_class
    file_system_path = klass.attachment_options[:path_prefix].to_s
    File.join(Dir::tmpdir, file_system_path,
              *partitioned_path(thumbnail_name_for(thumbnail)))
  end
end


describe AlbumsController do
  integrate_views

  before(:each) do
    @filename = "rails.png"
    @artist = artists(:foobars)
    @image = uploaded_file(@filename, "image/png")
    @title = "sldkfjasdflkj"
    @album = Album.create!({
            :uploaded_data => @image,
            :artist => @artist,
            :title => "a;sdkjfads;lfkj"
    })
  end

  it "should have an album" do
    @album.should_not be_nil
  end

  it "should render the 'index' template" do
    get :index
    response.should render_template('index')
  end

  it "should render the 'show' template" do
    get :show, :id => @album
    response.should render_template('show')
  end

end
