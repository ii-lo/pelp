class CoursesController < ApplicationController
  def show
    @course = Course.find params[:id]
    if att = Attending.where(course_id: @course.id, user_id: current_user.id).first
      att.update_last_visited
    end
  end

  def index
  end
end
