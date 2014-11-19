class CoursesController < ApplicationController

  before_action :load_course, except: [:index]

  def index
    @courses = Course.open.paginate(page: params[:page], per_page: 16)
  end

  def show
    @lesson_categories = @course.lesson_categories.includes :lessons, :exams
  end

  def grades
  end

  def activity
  end

  def info
  end

  def settings
  end

  def exam
    @course = Course.find params[:id]
    @exam = @course.exams.find_by_id params[:exam_id]
    return redirect_to course_path(@course.id) unless @exam
  end

  private

  def load_course
    @course = Course.find(params[:id])
    if at = Attending.where(course_id: @course.id, user_id: current_user.id).first
      at.update_last_visit
    end
  end

end
