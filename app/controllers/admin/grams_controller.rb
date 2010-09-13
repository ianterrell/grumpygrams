class Admin::GramsController < ApplicationController
  before_filter :authenticate
  layout 'admin'
  inherit_resources
  defaults :resource_class => Gram
  cache_sweeper :gram_sweeper
  
  def reorder
    params[:gram].each_with_index do |id, index|  
      Gram.update_all(["position=?", index+1], ["id=?", id])  
    end  
    render :text => "success"
  end
  
private
  def authenticate
    authenticate_or_request_with_http_basic do |username, password| 
      username == "grumpalope" && password == "sexysexymmm"
    end
  end
end
