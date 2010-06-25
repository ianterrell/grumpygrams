class GramInstancesController < ApplicationController
  
  before_filter :require_user
  
  def new
    @gram_instance = GramInstance.new
    @gram_instance.gram = Gram.find params[:id]
  end
  
  def create
    @gram_instance = GramInstance.new params[:gram_instance]
    if @gram_instance.save
      redirect_to :grams
    else
      render :action => :new
    end
  end
  
end
