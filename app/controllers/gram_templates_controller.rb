class GramTemplatesController < ApplicationController
  resource_controller
  
  create.response do |gram_template|
    gram_template.html {redirect_to(:gram_templates)}
  end
  
  update.response do |gram_template|
    gram_template.html {redirect_to(:gram_templates)}
  end

end
