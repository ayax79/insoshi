require File.dirname(__FILE__) + '/../spec_helper'

describe Artist do

  before(:each) do
    @artist = artists(:foobars)
  end

  it "should exist" do
    @artist.should_not be_nil
  end

  it "should require a name" do
    p = create_artist(:name => nil)
    p.errors.on(:name).should_not be_nil
  end

  it "should have a name equal to foobars" do
    @artist.name.should eql('foobars')
  end

  it "should have the correct bio" do
    @artist.bio.should_not be_nil
    @artist.bio.should eql('We are a band and we suck.')
  end

  it "should have members" do
    @artist.members.should be_a_kind_of(Array)
    @artist.members.should have(2).items
    @artist.members.should contain(people(:quentin))
    @artist.members.should contain(people(:aaron))
    @artist.members.should_not contain(people(:admin))
    @artist.members.should_not contain(people(:kelly))
  end

  it "should have fans" do
    @artist.fans.should be_a_kind_of(Array)
    @artist.fans.should have(2).items
    @artist.fans.should_not contain(people(:quentin))
    @artist.fans.should_not contain(people(:aaron))
    @artist.fans.should contain(people(:admin))
    @artist.fans.should contain(people(:kelly))
  end

  private

  def create_artist(options ={})
    a = Artist.new(options)
    a.valid?
    a.save if options[:save]
    a
  end

end