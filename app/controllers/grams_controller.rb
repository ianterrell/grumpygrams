class GramsController < ApplicationController
  caches_page :index
  def index
    @grams = Gram.all
  end
end
