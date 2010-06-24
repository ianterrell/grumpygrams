class GramsController < ApplicationController
  def index
    @grams = Gram.find :all
  end
  
  def new
    @gram = Gram.new
  end
  
  def create
    @gram = Gram.new params[:gram]
    if @gram.save
      flash[:success] = "#{@gram.name} has been created!"
      redirect_to :grams
    else
      render :action => :new
    end
  end
  
  def edit
    @gram = Gram.find params[:id]
  end
  
  def update
    @gram = Gram.find params[:id]
    if @gram.update_attributes params[:gram]
      redirect_to :grams
    else
      render :action => :edit
    end
  end
  
end
