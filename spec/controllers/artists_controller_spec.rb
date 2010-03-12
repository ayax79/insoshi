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
    lambda do
      lambda do
        person = login_as(:quentin)
        artist_hash = { :name => "another band", :description => "yes this band sucks too" }
        post :create, :artist => artist_hash, :addresses => ' foo1@bar.com foo2.bar.com '
        assigns(:artist).members.should contain_member_with_person(person)
        assigns(:artist).description.should == "yes this band sucks too"
        assigns(:artist).name.should == "another band"
        assigns(:artist).artist_invites.should_not be_nil
        assigns(:artist).artist_invites.size.should == 2

        response.should redirect_to(artist_url(assigns(:artist)))
      end.should change(Artist, :count).by(1)
    end.should change(ArtistMember, :count).by(1)
  end

  it "should have a working fan link" do
    person = login_as(:quentin)
    get :fan, :id => @artist
    response.should redirect_to(artist_url(@artist))
    assigns(:artist).fans.should contain(person)
  end

  it "should have an accept_member_invite action" do
    lambda do
      person = login_as(:bob)
      invite = @artist.artist_invites[0]
      get :accept_member_invite, :id => invite, :accept => true
      flash[:artist_invite].should_not be_nil
      assigns(:person).should == person
      assigns(:artist).members.should contain_member_with_person(person)
      assigns(:accept).should be_true
      response.should redirect_to(artist_url(assigns(:artist)))
    end.should change(ArtistMember, :count).by(1)
  end

  it "should have an edit page" do
    login_as(:quentin)
    get :edit, :id => @artist
    response.should render_template("edit")
  end

  it "should handle update" do
    lambda do
      login_as(:quentin)
      new_description = "adflasjdfasldfkj"
      post :update, :artist => { :description => new_description }, :addresses => 'another@foo.com', :id => @artist
      response.should redirect_to(artist_url(assigns(:artist)))
      assigns(:artist).description == new_description
    end.should change(ArtistInvite, :count).by(1)
  end

end