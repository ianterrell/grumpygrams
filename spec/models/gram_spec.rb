require 'spec_helper'

describe Gram do
  it "should create a new instance given valid attributes" do
    Factory(:gram).should be_valid
  end
  
  it { should belong_to(:gram_template) }
  
  it { should validate_presence_of(:to_name) }
  it { should validate_presence_of(:from_name) }
  it { should validate_presence_of(:to_email) }
  it { should validate_presence_of(:from_email) }
  it { should validate_presence_of(:gram_template_id) }
  
  it { should ensure_length_of(:to_name).is_at_least(3).is_at_most(32) }
  it { should ensure_length_of(:from_name).is_at_least(3).is_at_most(32) }
  it { should ensure_length_of(:to_email).is_at_least(3).is_at_most(255) }
  it { should ensure_length_of(:from_email).is_at_least(3).is_at_most(255) }
  it { should ensure_length_of(:message).is_at_least(3).is_at_most(255) }
  
  it { should allow_value("test@email.com").for(:to_email) }
  it { should allow_value("test@email.net").for(:to_email) }
  it { should allow_value("test.email@email.com").for(:to_email) }
  it { should_not allow_value("test@com").for(:to_email) }
  it { should_not allow_value("testemail.com").for(:to_email) }
  
  it { should allow_value("test@email.com").for(:from_email) }
  it { should allow_value("test@email.net").for(:from_email) }
  it { should allow_value("test.email@email.com").for(:from_email) }
  it { should_not allow_value("test@com").for(:from_email) }
  it { should_not allow_value("testemail.com").for(:from_email) }
  
  it { should_not allow_mass_assignment_of(:url_hash) }
  
  it "should generate a url hash when created" do
    u = Factory(:gram)
    u.url_hash.should be_nil
    u.save
    u.url_hash.should_not be_nil
  end
  
  describe "about the url hash" do
    before { Factory.create(:gram) } # shoulda implementation of uniqueness matcher requires at least one row in db
    it { should validate_uniqueness_of(:url_hash).with_message("Must be unique") }
  end
end
