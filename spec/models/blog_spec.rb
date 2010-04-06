require File.dirname(__FILE__) + '/../spec_helper'

describe Blog do

  it "should have many posts" do
    Blog.new.posts.should be_a_kind_of(Array)
  end

  it "should require a user or person" do
    lambda { Blog.create! }.should raise_error(ActiveRecord::RecordInvalid)
  end

  describe "people blogs" do
    it "should have a blog" do
      people(:admin).blog.should_not be_nil
    end
  end

  describe "artist blogs" do
    it "should have a blog" do
      artists(:foobars).blog.should_not be_nil
    end
  end

end
