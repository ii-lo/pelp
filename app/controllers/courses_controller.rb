class CoursesController < ApplicationController

  def index
    @courses = Course.open.paginate(page: params[:page], per_page: 16)
  end

  def show
    @course = Course.find params[:id]
    if lt = LastVisit.where(course_id: @course.id, user_id: current_user.id).first
      lt.update_date
    end
  end

end
