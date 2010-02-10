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

private
  def get_gram_templates
    @gram_templates = GramTemplate.find :all
  end
end
