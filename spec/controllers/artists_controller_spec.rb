require File.dirname(__FILE__) + '/../spec_helper'

describe ArtistsController do
  integrate_views

  before(:each) do
    @artist = artists(:foobars)
  end


  it "should render the 'index' template" do
    get :index
    response.should render_template('index')
  end

  it "should have a working show page" do
    get :show, :id => @artist.name
    response.should be_success
    response.should render_template("show")
  end

  it "should have a working create page" do
    login_as(:quentin)
    get :new
    response.should be_success
    response.should render_template("new")
  end

  it "should be able to create new arists" do
    person = login_as(:quentin)
    artist_hash = { :name => "another band", :bio => "yes this band sucks too" }
    post :create, :artist => artist_hash
    assigns(:artist).members.should contain(person)
    assigns(:artist).bio.should eql("yes this band sucks too")
    assigns(:artist).name.should eql("another band")

    response.should redirect_to(artist_url(assigns(:artist)))
  end

  it "should have a working fan link" do
    person = login_as(:quentin)
    get :fan, :id => @artist
    response.should redirect_to(artist_url(@artist))
    assigns(:artist).fans.should contain(person)
  end

end