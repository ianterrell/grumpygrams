require 'digest/sha1'

class Gram < ActiveRecord::Base  
  belongs_to :gram_template
  
  validates_presence_of :to_name, :to_email, :from_name, :from_email, :gram_template_id
  
  validates_length_of :to_name, :within => 3..32
  validates_length_of :to_email, :within => 3..255
  validates_length_of :from_name, :within => 3..32
  validates_length_of :from_email, :within => 3..255
  validates_length_of :message, :within => 3..255, :allow_blank => true
  
  validates_format_of :to_email, :with => Regex::EMAIL
  validates_format_of :from_email, :with => Regex::EMAIL
  
  attr_protected :confirm_token, :show_token
  after_create :generate_tokens, :send_confirmation_email
  validates_uniqueness_of :confirm_token, :allow_nil => true, :message => "Must be unique"
  validates_uniqueness_of :show_token, :allow_nil => true, :message => "Must be unique"
  
private

  def send_confirmation_email
    GramMailer.deliver_confirmation(self)
  end
  
  def generate_tokens
    self.update_attribute :confirm_token, Digest::SHA1::hexdigest("#{to_email}#{from_email}#{id}")
    self.update_attribute :show_token, Digest::SHA1::hexdigest("#{id}#{from_email}#{to_email}")
  end

end
