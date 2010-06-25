require 'mini_fb'

module ApplicationHelper
  
  def logged_in?
    current_user
  end
  
  def oauth_url
    @oauth_url = MiniFB.oauth_url(137471566265661, # your Facebook App ID
                                facebook_connect_url, # redirect url
                                :scope=>MiniFB.scopes.join(","))
  end
end
