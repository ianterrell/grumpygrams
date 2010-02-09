require 'spec_helper'

describe Gram do
  it "should be valid with a valid instance" do
    Factory(:gram).should be_valid
  end
  
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:slogan) }
end
