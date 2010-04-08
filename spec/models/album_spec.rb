require 'spec_helper'

describe Album do
  before(:each) do
    @valid_attributes = {
      :title => "value for name",
      :artist => artists(:foobars)
    }
  end

  it "should create a new instance given valid attributes" do
    Album.create!(@valid_attributes)
  end

  it "should require an artist" do
    lambda do
      Album.create! :title => "sdfasdf"
    end.should raise_error(ActiveRecord::RecordInvalid)
  end

end
