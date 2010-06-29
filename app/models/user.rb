class User < ActiveRecord::Base
  has_many :gram_instances
  
  acts_as_authentic do |c|
    c.login_field= :facebook_uid
  end
  
  def valid_access_token(*args)
    true
  end
  
  def profile_pic_url
    "http://graph.facebook.com/#{facebook_uid.to_s}/picture"
  end
  
end
