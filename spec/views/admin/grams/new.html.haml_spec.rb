require 'spec_helper'

describe "admin_grams/new.html.haml" do
  before(:each) do
    assign(:gram, stub_model(Admin::Gram,
      :new_record? => true
    ))
  end

  it "renders new gram form" do
    render

    rendered.should have_selector("form", :action => admin_grams_path, :method => "post") do |form|
    end
  end
end
