class GramsController < ApplicationController
  before_filter :get_gram_templates, :only => [:new, :create]
  
  def new
    @gram = Gram.new :gram_template => GramTemplate.default_template
  end
  
  def create
    @gram = Gram.new params[:gram]
    
    if verify_recaptcha(@gram) && @gram.save
      flash[:success] = "All good!  Check your email to confirm that you want to send this GrumpyGram!"
      redirect_to root_path
    else
      flash.now[:error] = "Uh oh!  We couldn't send your gram just yet.  Please check the form below for errors."
      render :action => "new"
    end
  end
  
  def confirm
    @gram = Gram.find_by_confirm_token params[:id]
    if @gram
      if @gram.confirmed?
        flash[:error] = "This GrumpyGram has already been confirmed!"
        redirect_to root_path
      else
        GramMailer.deliver_notification(@gram)
        @gram.update_attribute :confirmed, true
        flash[:success] = "Confirmed!  Your Grumpy Gram has been sent to #{@gram.to_name}"
        redirect_to root_path
      end
    else
      flash[:error] = "Invalid confirmation code"
      redirect_to root_path
    end
  end

  def show
    @gram = Gram.find_by_show_token! params[:id]
  end

private
  def get_gram_templates
    @gram_templates = GramTemplate.find :all
  end
end
