require File.dirname(__FILE__) + '/../spec_helper'

describe ExternalItem do

  before(:each) do
    @person = people(:quentin)
  end


  it "should create a valid entry for twitter" do
    values = { :provider => 'twitter',
               :person => @person,
               :post_date => 5.day.ago,
               :description => "I took a poop",
               :ext_id => 2353223}
    item = ExternalItem.create! values
    item.should_not be_nil
    item.id.should_not be_nil
    item = ExternalItem.find item
    item.provider.should == values[:provider]
    item.person.should == values[:person]
    item.post_date.should == values[:post_date]
    item.description.should == values[:description]
  end

  it "should require a person " do
    lambda do
      values = { :provider => 'twitter',
                 :post_date => 5.day.ago,
                 :description => "I took a poop",
                 :ext_id => 2353223}
      ExternalItem.create! values
    end.should raise_error
  end

  it "should require an ext_id for twitter " do
    lambda do
      values = { :provider => 'twitter',
                 :person => @person,
                 :post_date => 5.day.ago,
                 :description => "I took a poop" }
      ExternalItem.create! values
    end.should raise_error
  end

  it "should require a provider " do
    lambda do
      values = { :person => @person,
                 :post_date => 5.day.ago,
                 :description => "I took a poop" }
      ExternalItem.create! values
    end.should raise_error
  end

  it "should return the last twitter item for the specified user" do

    item = ExternalItem.find_last_twitter_item people(:bob)
    item.should_not be_nil
    item.description.should == 'Yes I cut the cheese'

  end
end
