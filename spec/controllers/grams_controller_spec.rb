require 'spec_helper'

describe GramsController do
  before(:all) do
    @gram = Factory.create(:gram)
  end
  
  it { should route(:get, "/grams/new").to(:action => :new) }
  it { should route(:post, "/grams").to(:action => :create) }
  it { should route(:get, "/grams/1").to(:action => :show, :id => 1) }
  it { should route(:get, "/grams/token").to(:action => :show, :id => "token") }

  it "should not route index" do
    lambda { get :index }.should raise_error(ActionController::RoutingError)
  end
  
  it "should not route edit" do
    lambda { get :edit, :id => 1 }.should raise_error(ActionController::RoutingError)
  end
  
  it "should not route update" do
    lambda { put :update, :id => 1 }.should raise_error(ActionController::RoutingError)
  end
  
  it "should not route destroy" do
    lambda { delete :destroy, :id => 1 }.should raise_error(ActionController::RoutingError)
  end

  it "should not use the id to show" do
    lambda { get :show, :id => @gram.id }.should raise_error(ActiveRecord::RecordNotFound)
  end
  
  it "should use the show token as id to show" do
    get :show, :id => @gram.show_token
    assigns[:gram].should == @gram
    response.should render_template("grams/show.html.erb")
  end

  it "should not use the id to confirm" do
    get :confirm, :id => @gram.id
    flash[:error].should == "Invalid confirmation code"
  end
  
  it "should redirect to root on bad confirm" do
    get :confirm, :id => "asdf"
    response.should redirect_to(root_path)
  end

  it "should use the confirm token as id to confirm" do
    get :confirm, :id => @gram.confirm_token
    flash[:success].should == "Confirmed!  Your Grumpy Gram has been sent to #{@gram.to_name}."
  end
  
  it "should send the mail to the recipient on confirmation" do
    GramMailer.should_receive(:deliver_notification)
    get :confirm, :id => @gram.confirm_token
  end
  
  describe "on successful confirmation" do
    before(:each) do
      get :confirm, :id => @gram.confirm_token
    end
    
    it "should redirect to root" do
      response.should redirect_to(root_path)
    end
    
    it "should set confirmed flag" do
      @gram.reload.should be_confirmed
    end
  end

  describe "if already confirmed" do
    before(:each) do
      @gram.update_attribute :confirmed, true
      get :confirm, :id => @gram.confirm_token      
    end
    
    it "should let the user know it's already been sent" do
      flash[:error].should == "This GrumpyGram has already been sent!"
    end
    
    it "should redirect to root" do
      response.should redirect_to(root_path)
    end
  end
  
  it "should not resend mail if already confirmed" do
    @gram.update_attribute :confirmed, true
    GramMailer.should_not_receive(:deliver_notification)
    get :confirm, :id => @gram.confirm_token
  end
end
