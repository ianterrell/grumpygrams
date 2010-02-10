class GramsController < ApplicationController
  resource_controller
  
  before_filter :get_gram_templates, :only => [:new, :create]
  
  def create
    
    @gram = Gram.new(params[:gram])
    
    if verify_recaptcha(@gram) && @gram.save!
       flash[:notice] = 'Gram was successfully created.'
       redirect_to(@gram)
    else
      render :action => 'new' # error shown in view
    end
    
  end
  
  def confirm
    @gram = Gram.find_by_url_hash(params[:url_hash])
    if @gram
      flash[:notice] = "Confirmed!  Your Grumpy Gram has been sent to #{@gram.to_name}"
      redirect_to(@gram)
    else
      flash[:notice] = 'Invalid confirmation code'
      redirect_to root_path
    end
  end

private
  def get_gram_templates
    @gram_templates = GramTemplate.find :all
  end
end
