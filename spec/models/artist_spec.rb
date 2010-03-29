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

  it "should have the correct description" do
    @artist.description.should_not be_nil
    @artist.description.should eql('We are a band and we suck.')
  end

  it "should have members" do
    @artist.members.should be_a_kind_of(Array)
    @artist.members.should have(2).items

    @artist.members.should contain_member_with_person(people(:quentin))
    @artist.members.should contain_member_with_person(people(:aaron))
    @artist.members.should_not contain_member_with_person(people(:admin))
    @artist.members.should_not contain_member_with_person(people(:kelly))
  end

  it "should have fans" do
    @artist.fans.should be_a_kind_of(Array)
    @artist.fans.should have(2).items
    @artist.fans.should_not contain(people(:quentin))
    @artist.fans.should_not contain(people(:aaron))
    @artist.fans.should contain(people(:admin))
    @artist.fans.should contain(people(:kelly))
  end

  it "should say quentin should be a member" do
    @artist.member?(people(:quentin)).should be_true
  end

  it "should say kelly is not a member" do
    @artist.member?(people(:kelly)).should_not be_true
  end

  private

  def create_artist(options ={})
    a = Artist.new(options)
    a.valid?
    a.save if options[:save]
    a
  end

  describe "activity associations" do

    it "should log an activity if description changed" do
      @artist.update_attributes(:description => "New Description")
      activity = Activity.find_by_item_id(@artist)
      Activity.global_feed.should contain(activity)
    end
#
#    it "should not log an activity if description didn't change" do
#      @artist.save!
#      activity = Activity.find_by_item_id(@artist)
#      Activity.global_feed.should_not contain(activity)
#    end
#
#    it "should disappear if the person is destroyed" do
#      person = create_person(:save => true)
#      # Create a feed activity.
#
#
#      Connection.connect(person, @artist)
#      @artist.update_attributes(:name => "New name")
#
#      Activity.find_all_by_person_id(person).should_not be_empty
#      person.destroy
#      Activity.find_all_by_person_id(person).should be_empty
#      Feed.find_all_by_person_id(person).should be_empty
#    end
#
#    it "should disappear from other feeds if the person is destroyed" do
#      initial_person = create_person(:save => true)
#      person         = create_person(:email => "new@foo.com", :name => "Foo",
#                                     :save => true)
#      Connection.connect(person, initial_person)
#      initial_person.activities.length.should == 1
#      person.destroy
#      initial_person.reload.activities.length.should == 0
#    end
  end

end


