class GramsController < ApplicationController
  def index
    @grams = Gram.all
  end
end
