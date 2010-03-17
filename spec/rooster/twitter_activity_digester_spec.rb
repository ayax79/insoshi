require File.dirname(__FILE__) + '/../spec_helper'
require File.dirname(__FILE__) + '/../../lib/rooster/tasks/twitter_activity_digester'

describe TwitterActivityDigester do

  USER_NAME='boop'

  before (:each) do
    @activity = mock
    @activity.stub!(:id).and_return(23234234)
    @activity.stub!(:created_at).and_return(5.days.ago)
    @activity.stub!(:text).and_return('blah blah blah blah')
    @activity.stub!(:ext_id).and_return(235235132)

    @twitter_search = mock(Twitter::Search)
    @twitter_search.stub!(:from).and_return(@twitter_search)
    @twitter_search.stub!(:since_date).and_return(@twitter_search)
    @twitter_search.stub!(:each).and_yield(@activity)
    Twitter::Search.stub!(:new).and_return(@twitter_search)
    @person = people(:quentin)
    @digester = TwitterActivityDigester.new(nil)
  end

  describe 'twitter_activity' do

    it "should call with since_date" do
      @twitter_search.should_receive(:from).with(USER_NAME).and_return(@twitter_search)
      @twitter_search.should_receive(:since_date).with(@activity.created_at).and_return(@twitter_search)
      @twitter_search.should_not_receive :since
      count = 0
      @digester.twitter_activity(USER_NAME, :since_date => @activity.created_at) do |x|
        x.should == @activity
        count = count + 1
      end
      count.should == 1
    end

    it "should call with since" do
      @twitter_search.should_receive(:from).with(USER_NAME).and_return(@twitter_search)
      @twitter_search.should_receive(:since).with(@activity.ext_id).and_return(@twitter_search)
      @twitter_search.should_not_receive :since_date
      count = 0

      @digester.twitter_activity(USER_NAME, :since => @activity.ext_id) do |x|
        x.should == @activity
        count = count + 1
      end
      count.should == 1
    end

  end

  it "should enter external activity with mocked twitter activity by using create date" do

    ExternalCred.find_all_twitter.size.should == 1


    lambda do
      @digester.execute_task
    end.should change(ExternalItem, :count).by(1)


  end

end