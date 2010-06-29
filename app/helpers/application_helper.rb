require 'mini_fb'

module ApplicationHelper
  
  def logged_in?
    current_user
  end
  
  def profile_pic_url(uid)
    "http://graph.facebook.com/#{uid.to_s}/picture"
  end
  
  def oauth_url
    scopes = MiniFB.scopes<<"email"
    @oauth_url = MiniFB.oauth_url(137471566265661, # your Facebook App ID
                                facebook_connect_url, # redirect url
                                :scope=>scopes.join(","))
  end
end
