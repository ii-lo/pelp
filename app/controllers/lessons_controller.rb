class LessonsController < ApplicationController
  before_action :load_course
  def new
    
  end

  private

  def load_course
    @course = Course.find params[:course_id]
  end
end
