class LessonsController < ApplicationController
  before_action :load_course
  def new
    @lesson = @course.lessons.build
    authorize(@lesson)
  end

  def create
    
  end

  private

  def load_course
    @course = Course.find params[:course_id]
  end
end
