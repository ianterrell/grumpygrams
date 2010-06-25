require 'mini_fb'

class UserSessionsController < ApplicationController
  
  def facebook_connect
    access_token_hash = MiniFB.oauth_access_token(137471566265661, facebook_connect_url, "9db8f39e7d7085c5fb7a42f94ae74451", params[:code])
    @access_token = access_token_hash["access_token"]
    logger.info "#{@access_token}"
    redirect_to :root
  end

  def destroy
    current_user_session.destroy
    redirect_back_or_default grams_url
  end
  
end
