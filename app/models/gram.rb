class Gram < ActiveRecord::Base
  belongs_to :gram_template
  
  validates_presence_of :to_name, :to_email, :from_name, :from_email, :message, :gram_template_id
  
  validates_length_of :to_name, :within => 3..32
  validates_length_of :to_email, :within => 3..255
  validates_length_of :from_name, :within => 3..32
  validates_length_of :from_email, :within => 3..255
  validates_length_of :message, :within => 3..255
  
  validates_format_of :to_email, :with => Regex::EMAIL
  validates_format_of :from_email, :with => Regex::EMAIL
end
