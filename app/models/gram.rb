class Gram < ActiveRecord::Base
  has_many :gram_instances
  
  validates_presence_of :name, :phrase
  validates_length_of :name, :within => 3..64
  validates_length_of :phrase, :within => 3..255
  validates_uniqueness_of :name, :on => :create, :case_sensitive => false, :message => "Must have a unique name"
end
