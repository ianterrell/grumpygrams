require 'spec_helper'

describe "admin_grams/edit.html.haml" do
  before(:each) do
    @gram = assign(:gram, stub_model(Admin::Gram,
      :new_record? => false
    ))
  end

  it "renders the edit gram form" do
    render

    rendered.should have_selector("form", :action => gram_path(@gram), :method => "post") do |form|
    end
  end
end
