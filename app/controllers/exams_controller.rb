class ExamsController < ApplicationController
  def new
    @course = Course.find params[:course_id]
    if params[:lesson_category_id]
      @l_c = @course.lesson_categories.find(params[:lesson_category_id])
    else
      @l_c = nil
    end
    @exam = Exam.new(course: @course)
    authorize(@exam)
  end

  def create
    @course = Course.find params[:course_id]
    @exam = @course.exams.build(exam_params)
    authorize(@exam)
    if @exam.save
      redirect_to edit_course_exam_path(@course, @exam)
    else
      render 'new'
    end
  end

  def edit
    @course ||= Course.find params[:course_id]
    @exam ||= Exam.find params[:id]
    @q_cs ||= @exam.question_categories.includes :questions, :answers
    @u_exams = @exam.user_exams.includes(:user).order(created_at: :asc)
      .paginate(page: params[:page], per_page: 15)
    @markdown = markdown_renderer
  end

  def update
    @course = Course.find params[:course_id]
    @exam = Exam.find params[:id]
    if @exam.update_attributes(update_params)
      redirect_to edit_course_exam_path(@course, @exam),
        notice: "Zaaktualizowano"
    else
      edit
      render 'edit'
    end
  end

  private

  def exam_params
    params.require(:exam).permit(:name, :lesson_category_id, :duration, :one_run)
  end

  def update_params
    params.require(:exam).permit(:name, :duration, :published, :one_run)
  end

end
