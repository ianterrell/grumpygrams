class User < ActiveRecord::Base
  acts_as_authentic
  
  def profile_pic_url
    "http://graph.facebook.com/" + facebook_uid.to_s + "/picture"
  end
  
end
