
class Gram < ActiveRecord::Base
  include Paperclip
  
  has_many :gram_instances
  
  has_attached_file :image, :styles => { :thumb => "100x100" }, :storage => :s3,
      :s3_credentials => "#{RAILS_ROOT}/config/s3.yml", :path => ':class/:id/:style.:extension'

  validates_attachment_presence :image, :message => 'Please select an image'
  validates_attachment_size :image, :less_than => 100.kilobytes, :message => 'Image must be less than 100kb.'
  validates_attachment_content_type :image, :content_type => ['image/jpeg', 'image/png'], :message => 'Image must be a jpeg or png file.'
  
  validates_presence_of :name, :phrase
  validates_length_of :name, :within => 3..64
  validates_length_of :phrase, :within => 3..255
  validates_uniqueness_of :name, :on => :create, :case_sensitive => false, :message => "Must have a unique name"
end
