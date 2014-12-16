class ExamsController < ApplicationController
  def new
    @course = Course.find params[:course_id]
    @exam = Exam.new(course: @course)
    authorize(@exam)
  end

  def create
    @course = Course.find params[:course_id]
    @exam = Exam.new(exam_params.merge(course: @course))
    if @exam.save
      redirect_to edit_course_exam_path(@course, @exam)
    else
      render 'new'
    end
  end

  def edit
  end

  def update
  end

  private

  def exam_params
    params.require(:exam).permit(:name, :lesson_category_id, :duration)
  end

end
