require 'spec_helper'

describe Admin::GramsController do

  def mock_gram(stubs={})
    @mock_gram ||= mock_model(Admin::Gram, stubs).as_null_object
  end

  describe "GET index" do
    it "assigns all admin_grams as @admin_grams" do
      Admin::Gram.stub(:all) { [mock_gram] }
      get :index
      assigns(:admin_grams).should eq([mock_gram])
    end
  end

  describe "GET show" do
    it "assigns the requested gram as @gram" do
      Admin::Gram.stub(:find).with("37") { mock_gram }
      get :show, :id => "37"
      assigns(:gram).should be(mock_gram)
    end
  end

  describe "GET new" do
    it "assigns a new gram as @gram" do
      Admin::Gram.stub(:new) { mock_gram }
      get :new
      assigns(:gram).should be(mock_gram)
    end
  end

  describe "GET edit" do
    it "assigns the requested gram as @gram" do
      Admin::Gram.stub(:find).with("37") { mock_gram }
      get :edit, :id => "37"
      assigns(:gram).should be(mock_gram)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created gram as @gram" do
        Admin::Gram.stub(:new).with({'these' => 'params'}) { mock_gram(:save => true) }
        post :create, :gram => {'these' => 'params'}
        assigns(:gram).should be(mock_gram)
      end

      it "redirects to the created gram" do
        Admin::Gram.stub(:new) { mock_gram(:save => true) }
        post :create, :gram => {}
        response.should redirect_to(admin_gram_url(mock_gram))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved gram as @gram" do
        Admin::Gram.stub(:new).with({'these' => 'params'}) { mock_gram(:save => false) }
        post :create, :gram => {'these' => 'params'}
        assigns(:gram).should be(mock_gram)
      end

      it "re-renders the 'new' template" do
        Admin::Gram.stub(:new) { mock_gram(:save => false) }
        post :create, :gram => {}
        response.should render_template("new")
      end
    end

  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested gram" do
        Admin::Gram.should_receive(:find).with("37") { mock_gram }
        mock_admin_gram.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :gram => {'these' => 'params'}
      end

      it "assigns the requested gram as @gram" do
        Admin::Gram.stub(:find) { mock_gram(:update_attributes => true) }
        put :update, :id => "1"
        assigns(:gram).should be(mock_gram)
      end

      it "redirects to the gram" do
        Admin::Gram.stub(:find) { mock_gram(:update_attributes => true) }
        put :update, :id => "1"
        response.should redirect_to(admin_gram_url(mock_gram))
      end
    end

    describe "with invalid params" do
      it "assigns the gram as @gram" do
        Admin::Gram.stub(:find) { mock_gram(:update_attributes => false) }
        put :update, :id => "1"
        assigns(:gram).should be(mock_gram)
      end

      it "re-renders the 'edit' template" do
        Admin::Gram.stub(:find) { mock_gram(:update_attributes => false) }
        put :update, :id => "1"
        response.should render_template("edit")
      end
    end

  end

  describe "DELETE destroy" do
    it "destroys the requested gram" do
      Admin::Gram.should_receive(:find).with("37") { mock_gram }
      mock_admin_gram.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the admin_grams list" do
      Admin::Gram.stub(:find) { mock_gram }
      delete :destroy, :id => "1"
      response.should redirect_to(admin_grams_url)
    end
  end

end
