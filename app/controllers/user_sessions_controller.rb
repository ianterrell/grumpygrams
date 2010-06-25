require 'mini_fb'

class UserSessionsController < ApplicationController
  
  def facebook_connect
    @fb_info = MiniFB.parse_cookie_information('fd577fc6f9d8d122717f0fdd6112e234', cookies)
    redirect_to :grams
  end

  def destroy
    current_user_session.destroy
    redirect_back_or_default grams_url
  end
  
end
