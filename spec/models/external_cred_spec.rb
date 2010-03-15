require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe ExternalCred do
  before(:each) do
    @person = people(:quentin)
    @valid_attributes = {
            :provider => 'twitter',
            :username => "quentin",
            :identifier => "http://twitter.com/quentin",
            :person => @person
    }
  end

  it "should create a new instance given valid attributes" do
    cred = ExternalCred.create! @valid_attributes
    cred = ExternalCred.find cred
    cred.provider.should == @valid_attributes[:provider]
    cred.username.should == @valid_attributes[:username]
    cred.identifier.should == @valid_attributes[:identifier]
    cred.person.should == @person
  end
end
