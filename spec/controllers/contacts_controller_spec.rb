require 'spec_helper'

describe ContactsController do
  render_views

  before :each do
    @user                                 = create :user
    session[:user_id]                     = @user.id
    session[:user_email]                  = @user.corporate_email
    session[:avatar_url]                  = "/favicon.ico"
    session[:google_api_token]            = "<dummy token>"
    session[:google_api_token_expires_at] = 1.hour.since.to_i
  end

  it 'should render "index"' do
    get :index
    response.should be_success
  end


  it "should provide 'new' partial for the case when nothing to add" do
    expect(@controller.contacts_service).to receive(:known_emails).and_return([@user.private_email])
    xhr :get, :new
    response.should be_success
    assigns(:users_to_add).should == []
  end

  it "should provide 'new' partial for the case when there's 1 user to add" do
    expect(@controller.contacts_service).to receive(:known_emails).and_return([])
    xhr :get, :new
    response.should be_success
    assigns(:users_to_add).should == [@user]
  end


end