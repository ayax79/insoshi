require File.dirname(__FILE__) + '/../spec_helper'

describe ArtistMailer do

  before(:each) do
    @preferences = preferences(:one)
    @server = @preferences.server_name
    @domain = @preferences.domain
  end

  describe "Artist Invitations" do
    before(:each) do
      @person = people(:quentin)
      @artist = artists(:foobars)
      @email = ArtistMailer.create_artist_invite_notification_non_member(@artist, @person.email)
    end

    it "should have the right sender" do
      @email.from.first.should == "message@#{@domain}"
    end

    it "should have the right recipient" do
      @email.to.first.should == @person.email
    end

  end

end