require File.dirname(__FILE__) + '/../spec_helper'

describe ArtistMember do

  before(:each) do
    @artist = artists(:foobars)
    @person = people(:isaac)
  end

  it "should join the stream properly" do

    lambda do
      ArtistMember.create!(:artist => @artist, :person => @person, :description => 'woot')
    end.should change(Activity, :count).by(1)

  end

end
