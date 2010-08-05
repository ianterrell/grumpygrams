require 'spec_helper'

describe "admin_grams/index.html.haml" do
  before(:each) do
    assign(:admin_grams, [
      stub_model(Admin::Gram),
      stub_model(Admin::Gram)
    ])
  end

  it "renders a list of admin_grams" do
    render
  end
end
