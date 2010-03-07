require File.dirname(__FILE__) + '/../spec_helper'

describe ArtistInvite do
  before(:each) do
    @artist = artists(:foobars)
  end

  #noinspection RubyResolve
  it "should allow new invites to be added" do
    invite = ArtistInvite.new({:email => "foo@sldfkj.com", :artist => @artist})
    @artist.artist_invites << invite
    @artist.save!
    Artist.find(@artist).artist_invites.should contain(invite)
    invite.artist_id.should_not be_nil
  end

end
