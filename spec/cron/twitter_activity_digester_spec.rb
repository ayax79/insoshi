require File.dirname(__FILE__) + '/../spec_helper'
require File.dirname(__FILE__) + '/../../lib/cron/twitter_activity_digester'
require 'hashie/mash'

describe TwitterActivityDigester do

  USER_NAME='boop'

  before (:each) do
    @activity = mock(Hashie::Mash)
    @activity.stub!(:id).and_return(23234234)
    @activity.stub!(:created_at).and_return(5.days.ago)
    @activity.stub!(:text).and_return('blah blah blah blah')
    @activity.stub!(:ext_id).and_return(235235132)

    @twitter_search = mock(Twitter::Search)
    @twitter_search.stub!(:from).and_return(@twitter_search)
    @twitter_search.stub!(:since_date).and_return(@twitter_search)
    @twitter_search.stub!(:fetch).and_return('results' => [@activity])
    Twitter::Search.stub!(:new).and_return(@twitter_search)
    @person = people(:quentin)
    @digester = TwitterActivityDigester.new
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
        puts "called"
        x.should == @activity
        count = count + 1
      end
      count.should == 1
    end

  end

  it "should enter external activity with mocked twitter activity by using create date" do

    @twitter_search.should_receive(:since).and_return(@twitter_search)
    lambda do
      @digester.run
    end.should change(ExternalItem, :count).by(1)


  end

end