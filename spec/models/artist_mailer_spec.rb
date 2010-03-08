require File.dirname(__FILE__) + '/../spec_helper'

describe ArtistMailer do

  before(:each) do
    @preferences = preferences(:one)
    @server = @preferences.server_name
    @domain = @preferences.domain
    @person = people(:quentin)
    @artist = artists(:foobars)
  end

  describe "Artist Invitations For non members" do
    before(:each) do
      @email = ArtistMailer.create_artist_invite_notification_non_member(@artist, @person.email)
    end

    it "should have the right sender" do
      @email.from.first.should == "message@#{@domain}"
    end

    it "should have the right recipient" do
      @email.to.first.should == @person.email
    end

    it "should reference the artists name" do
      @email.body.should =~ /#{@artist.name}/
    end

    it "should contain the signup url" do
      @email.body.should =~ /signup/
    end

  end

  describe "Artist Invitations for members" do
    before(:each) do
      @email = ArtistMailer.create_artist_invite_notification(@artist, @person)
    end

    it "should have the right sender" do
      @email.from.first.should == "message@#{@domain}"
    end

    it "should have the right recipient" do
      @email.to.first.should == @person.email
    end

    it "should reference the artists name" do
      @email.body.should =~ /#{@artist.name}/
    end

    it "should contain the person's name" do
      @email.body.should =~ /#{@person.name}/
    end

    it "should contain the login url" do
      @email.body.should =~ /login/
    end

  end

end