class StaticPagesController < ApplicationController
  def home
    flash[:error] = "Przykladowy error"
    flash[:notice] = "Przykladowy notice"
    flash[:info] = "Przykladowe info"
    flash[:alert] = "Przykladowy alert"
  end
end
