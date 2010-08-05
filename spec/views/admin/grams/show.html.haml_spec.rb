require 'spec_helper'

describe "admin_grams/show.html.haml" do
  before(:each) do
    @gram = assign(:gram, stub_model(Admin::Gram))
  end

  it "renders attributes in <p>" do
    render
  end
end
