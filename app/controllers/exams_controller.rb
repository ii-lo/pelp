class ExamsController < ApplicationController
  def new
    #TODO authorization
    @course = Course.find params[:course_id]
  end

  def create
    raise NotImplementedError
  end

end
