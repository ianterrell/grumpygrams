class GramsController < ApplicationController
  def index
    response.headers['Cache-Control'] = 'public, max-age=604800'
    @grams = Gram.all
  end
end
