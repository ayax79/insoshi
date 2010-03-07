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

  it "should be able to create new artists" do
    person = login_as(:quentin)
    artist_hash = { :name => "another band", :bio => "yes this band sucks too" }
    post :create, :artist => artist_hash, :addresses => ' foo1@bar.com foo2.bar.com '
    assigns(:artist).members.should contain(person)
    assigns(:artist).bio.should == "yes this band sucks too"
    assigns(:artist).name.should == "another band"
    assigns(:artist).artist_invites.should_not be_nil
    assigns(:artist).artist_invites.size.should == 2

    response.should redirect_to(artist_url(assigns(:artist)))
  end

  it "should have a working fan link" do
    person = login_as(:quentin)
    get :fan, :id => @artist
    response.should redirect_to(artist_url(@artist))
    assigns(:artist).fans.should contain(person)
  end

end