require 'mini_fb'

class UserSessionsController < ApplicationController
  
  def facebook_connect
    access_token_hash = MiniFB.oauth_access_token(137471566265661, facebook_connect_url, "9db8f39e7d7085c5fb7a42f94ae74451", params[:code])
    @access_token = access_token_hash["access_token"]
    @response_hash = MiniFB.get(@access_token, "me")
    @user = User.find_by_facebook_uid @response_hash[:id]
    if @user == nil
      @user = User.new
      @user.facebook_uid = @response_hash[:id]
    end
    @user.name = @response_hash[:name]
    @user.facebook_username = @response_hash[:username]
    @user.first_name = @response_hash[:first_name]
    @user.last_name = @response_hash[:first_name]
    @user.email = @response_hash[:email]
    @user.access_token = @access_token
    @user.save!
    redirect_to :root
  end

  def destroy
    current_user_session.destroy
    redirect_back_or_default grams_url
  end
  
end
