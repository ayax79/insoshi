require File.dirname(__FILE__) + '/../spec_helper'

describe Artist do

  before(:each) do
    @artist = artists(:one)
  end

  it "should exist" do
    @artist.should_not be_nil
  end

  it "should require a name" do
    p = create_artist(:name => nil)
    p.errors.on(:name).should_not be_nil
  end

  it "should have members" do
    @artist.members.should be_a_kind_of(Array)
  end

  it "should have fans" do
    @artist.fans.should be_a_kind_of(Array)
  end

  private

  def create_artist(options ={})
    a = Artist.new(options)
    a.valid?
    a.save if options[:save]
    a
  end
  
end