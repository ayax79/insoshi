require File.dirname(__FILE__) + '/../spec_helper'

describe ArtistHelper do
  include ArtistHelper

  before(:each) do
    @artist = artists(:foobars)
  end

  it "should have say quentin is a member of foobars" do
    is_member(people(:quentin), @artist).should be_true
  end

  it "should not have kelly as a member of foobars" do
    is_member(people(:kelly), @artist).should be_false
  end

  it "should not say nil is a member" do
    is_member(nil, @artist).should be_false
  end

  it "should have kelly as a fan of foobars" do
    is_fan(people(:kelly), @artist).should be_true
  end

  it "should not have quentin as a fan of foobars" do
    is_fan(people(:quentin), @artist).should be_false
  end

  it "should not say nil is a fan" do
    is_fan(nil, @artist).should be_false
  end

  it "should have no be a fan link" do
    fan_link(people(:quentin), @artist).should be_nil
  end

  it "should have a fan link" do
    mock_person = mock('Person')
    mock_person.stub!(:id => 40000, :membered_artists => [], :fanned_artists => [])
    fan_link(mock_person, @artist).should == link_to('Become a Fan', { :controller => 'artists', :action => 'fan', :id => @artist})
  end
end