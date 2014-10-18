class CoursesController < ApplicationController

  def index
    @courses = Course.open.paginate(page: params[:page], per_page: 30)
  end

  def show
    @course = Course.find params[:id]
    if att = Attending.where(course_id: @course.id, user_id: current_user.id).first
      att.update_last_visited
    end
  end

end
