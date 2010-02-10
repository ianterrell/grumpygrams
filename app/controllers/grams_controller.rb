class GramsController < ApplicationController
  resource_controller
  
  before_filter :get_gram_templates, :only => [:new, :create]

private
  def get_gram_templates
    @gram_templates = GramTemplate.find :all
  end
end
