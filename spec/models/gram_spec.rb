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
  it { should validate_presence_of(:message) }
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
end