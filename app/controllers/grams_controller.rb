class GramsController < ApplicationController
  def index
    @grams = Gram.find :all
  end
end
