require 'spec_helper'

describe Song do

  before(:each) do
    @mp3 = uploaded_file "test.mp3", "audio/mpeg"
    @title = "The Song Remains The Same"
    @album = albums(:houses_of_the_holy)
  end

  it "create a valid object" do
    Song.create! :uploaded_data => @mp3,
                 :album => @album,
                 :title => @title
  end

  it "should require a title" do
    lambda do
      Song.create! :uploaded_data => @mp3,
                   :album => @album
    end.should raise_error ActiveRecord::RecordInvalid
  end

  it "should require a album" do
    lambda do
      Song.create! :uploaded_data => @mp3,
                   :title => @title
    end.should raise_error ActiveRecord::RecordInvalid
  end

  it "should require upload_data" do
    lambda do
      Song.create! :title => @title,
                   :album => @album
    end.should raise_error ActiveRecord::RecordInvalid
  end

end
