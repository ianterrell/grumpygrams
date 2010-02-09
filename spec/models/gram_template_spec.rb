require 'spec_helper'

describe GramTemplate do
  it "should be valid with a valid instance" do
    Factory(:gram_template).should be_valid
  end
  
  it { should have_many(:grams) }
  
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:slogan) }
  it { should ensure_length_of(:name).is_at_least(3).is_at_most(64) }
  it { should ensure_length_of(:slogan).is_at_least(3).is_at_most(255) }
  it { should validate_uniqueness_of(:name).case_insensitive }
  

end
