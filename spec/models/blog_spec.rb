require File.dirname(__FILE__) + '/../spec_helper'

describe Blog do
  it "should have many posts" do
    Blog.new.posts.should be_a_kind_of(Array)
  end
  it "should have a blog" do
    people(:admin).blog.should_not be_nil
  end
end
