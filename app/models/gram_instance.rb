class GramInstance < ActiveRecord::Base
  belongs_to :gram
  belongs_to :user
  
  validates_presence_of :user_id, :recipient_facebook_uid, :message, :gram_id
  
  validates_length_of :message, :within => 3..255, :allow_blank => true
  
end
