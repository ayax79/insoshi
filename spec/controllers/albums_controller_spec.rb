require 'spec_helper'

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
