class CoursesController < ApplicationController

  before_action :load_course, except: [:index]

  def index
    @courses = Course.open.paginate(page: params[:page], per_page: 16)
  end

  def show
    @lesson_categories = @course.lesson_categories.includes :lessons
    (@exams = policy_scope(@course.exams).group_by(&:lesson_category_id)).default = []
    @admin = @course.admins.include? current_user
  end

  def settings
  end

  private

  def load_course
    @course = Course.find(params[:id])
    if at = Attending.where(course_id: @course.id, user_id: current_user.id).first
      at.update_last_visit
    end
  end

end
