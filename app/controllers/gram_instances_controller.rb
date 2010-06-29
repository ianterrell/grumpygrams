require 'mini_fb'

class GramInstancesController < ApplicationController
  
  before_filter :require_user
  
  def new
    @gram_instance = GramInstance.new
    @gram_instance.gram = Gram.find params[:id]
    friends_hash = MiniFB.get(current_user.access_token, "me", :type => 'friends')
    @friends = friends_hash[:data]
  end
  
  def create
    @gram_instance = GramInstance.new params[:gram_instance]
    @gram_instance.user = current_user
    if @gram_instance.save
      redirect_to :grams
    else
      friends_hash = MiniFB.get(current_user.access_token, "me", :type => 'friends')
      @friends = friends_hash[:data]
      render :action => :new
    end
  end
  
end
