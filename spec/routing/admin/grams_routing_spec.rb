require "spec_helper"

describe Admin::GramsController do
  describe "routing" do

        it "recognizes and generates #index" do
      { :get => "/admin_grams" }.should route_to(:controller => "admin_grams", :action => "index")
    end

        it "recognizes and generates #new" do
      { :get => "/admin_grams/new" }.should route_to(:controller => "admin_grams", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/admin_grams/1" }.should route_to(:controller => "admin_grams", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/admin_grams/1/edit" }.should route_to(:controller => "admin_grams", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/admin_grams" }.should route_to(:controller => "admin_grams", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/admin_grams/1" }.should route_to(:controller => "admin_grams", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/admin_grams/1" }.should route_to(:controller => "admin_grams", :action => "destroy", :id => "1")
    end

  end
end
