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
      publish_response = MiniFB.post(current_user.access_token, @gram_instance.recipient_facebook_uid, 
                                      :type => 'feed', :message => "#{@gram_instance.user.name} thinks you are grumpy!", 
                                      :picture => "#{@gram_instance.gram.image.url :thumb}", :link => "http://www.grumpygrams.com/", 
                                      :name => "GrumpyGrams", :caption => "#{@gram_instance.gram.name}", :description => "#{@gram_instance.gram.phrase}" )
      redirect_to :grams
    else
      friends_hash = MiniFB.get(current_user.access_token, "me", :type => 'friends')
      @friends = friends_hash[:data]
      render :action => :new
    end
  end
  
end
