class MainController < ApplicationController
  def index; end
  def icons
    flash.now[:success] = "This is success."
    flash.now[:notice] = "This is notice."
    flash.now[:error] = "This is error."
  end # TODO: remove me
end
