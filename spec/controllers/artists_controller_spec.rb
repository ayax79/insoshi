require File.dirname(__FILE__) + '/../spec_helper'

describe ArtistsController do

  before(:each) do
    @artist = artists(:foobars)
  end


  it "should render the 'index' template" do
    get :index
    response.should render_template('index')
  end

  it "should have a working show page" do
    get :show, :id => @artist
    response.should be_success
    response.should render_template("show")
  end

end