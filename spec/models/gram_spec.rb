require 'spec_helper'

describe Gram do
  before(:all) do
    @first = Factory.create(:gram)
    @second = Factory.create(:gram)
  end
  
  it "should be valid with a valid instance" do
    Factory(:gram).should be_valid
  end

  it { should have_many(:gram_instances) }
  
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:phrase) }
  it { should ensure_length_of(:name).is_at_least(3).is_at_most(64) }
  it { should ensure_length_of(:phrase).is_at_least(3).is_at_most(255) }
  it { should validate_uniqueness_of(:name).case_insensitive.with_message("Must have a unique name")}
end
