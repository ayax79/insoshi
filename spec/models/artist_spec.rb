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
    @artist.members.should contain_person_with_name('Quentin')
    @artist.members.should contain_person_with_name('Aaron')
    @artist.members.should_not contain_person_with_name('admin')
    @artist.members.should_not contain_person_with_name('Kelly')
  end

  it "should have fans" do
    @artist.fans.should be_a_kind_of(Array)
    @artist.fans.should have(2).items
    @artist.fans.should_not contain_person_with_name('Quentin')
    @artist.fans.should_not contain_person_with_name('Aaron')
    @artist.fans.should contain_person_with_name('admin')
    @artist.fans.should contain_person_with_name('Kelly')
  end

  private

  def contain_person_with_name(name)
    return ContainPersonWithName.new(name)
  end

  class ContainPersonWithName
    def initialize(expected)
      @expected = expected
    end
    def matches?(target)
      @target = target

      found = false
      target.each do |person|
        found = true if person.name == @expected
      end
      found
    end
    
    def failure_message
      "expected #{@target.inspect} to contain person with name #{@expected}"
    end
    def negative_failure_message
      "expected #{@target.inspect} not contain person with name #{@expected}"
    end
  end

  def create_artist(options ={})
    a = Artist.new(options)
    a.valid?
    a.save if options[:save]
    a
  end

end