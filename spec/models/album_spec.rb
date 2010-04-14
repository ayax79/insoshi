require 'spec_helper'

describe Album do
  before(:each) do
    @filename = "rails.png"
    @image = uploaded_file(@filename, "image/png")
    @artist = artists(:foobars)
    @title = "value for name"
  end

  it "should create a new instance given valid attributes" do
    Album.create!({ :uploaded_data => @image,
                    :artist        => @artist,
                    :title       => @title }).should_not be_nil
  end

  it "should require an artist" do
    lambda do
      Album.create! :title => @title, :uploaded_data => @image
    end.should raise_error(ActiveRecord::RecordInvalid)
  end

  it "should require an image" do
    lambda do
      Album.create! :title => @title, :artist => @artist
    end.should raise_error(ActiveRecord::RecordInvalid)
  end

  it "should require a title" do
    lambda do
      Album.create! :artist => @artist, :uploaded_data => @image
    end.should raise_error(ActiveRecord::RecordInvalid)
  end

  it "should have songs" do
    albums(:houses_of_the_holy).songs.should contain songs(:over_the_hills)
  end

end
