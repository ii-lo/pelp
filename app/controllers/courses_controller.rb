class CoursesController < ApplicationController

  before_action :load_course, except: [:index]
  def index
    @courses = Course.open.paginate(page: params[:page], per_page: 16)
  end

  def show
  end

  def messages
  end

  def bookmarks
  end

  def deadlines
  end

  private

  def load_course
    @course = Course.find params[:id]
    if at = Attending.where(course_id: @course.id, user_id: current_user.id).first
      at.update_last_visit
    end
  end

end
