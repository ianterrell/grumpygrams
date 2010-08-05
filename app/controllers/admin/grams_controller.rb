class Admin::GramsController < ApplicationController
  before_filter :authenticate
  layout 'admin'
  inherit_resources
  defaults :resource_class => Gram
  
private
  def authenticate
    authenticate_or_request_with_http_basic do |username, password| 
      username == "grumpalope" && password == "sexysexymmm"
    end
  end
end
