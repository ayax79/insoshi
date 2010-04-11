require 'spec_helper'

describe AlbumThumbnail do
  it "should be valid" do
    @thumbnail = AlbumThumbnail.new({:parent_id => 1})
    @thumbnail.should be_valid
  end

  it "should be invalid without parent_id" do
    @thumbnail = AlbumThumbnail.new
    @thumbnail.should_not be_valid
  end
end
