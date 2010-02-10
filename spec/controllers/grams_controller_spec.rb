require 'spec_helper'

describe GramsController do
  before(:all) do
    @gram = Factory.create(:gram)
  end

  it "should not use the id to show" do
    begin
      get :show, :id => @gram.id
      fail
    rescue ActiveRecord::RecordNotFound
    end
  end
  
  it "should use the show token as id to show" do
    get :show, :id => @gram.show_token
    assigns[:gram].should == @gram
  end

  it "should not use the id to confirm" do
    get :confirm, :id => @gram.id
    flash[:error].should == "Invalid confirmation code"
  end

  it "should use the confirm token as id to confirm" do
    get :confirm, :id => @gram.confirm_token
    flash[:success].should == "Confirmed!  Your Grumpy Gram has been sent to #{@gram.to_name}"
  end

  it "should not confirm a gram that has already been confirmed" do
    @gram.update_attribute :confirmed, true
    get :confirm, :id => @gram.confirm_token
    flash[:error].should == "This GrumpyGram has already been confirmed!"
  end
end
