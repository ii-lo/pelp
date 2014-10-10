class StaticPagesController < ApplicationController
  def home
    flash[:error] = "Przykladowy error"
  end
end
