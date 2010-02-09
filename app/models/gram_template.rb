class GramTemplate < ActiveRecord::Base
  has_many :grams
  
  validates_presence_of :name, :slogan
  validates_length_of :name, :within => 3..64
  validates_length_of :slogan, :within => 3..255
  validates_uniqueness_of :name, :on => :create, :case_sensitive => false, :message => "Must have a unique name"
  
end
