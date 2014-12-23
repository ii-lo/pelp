class ExamsController < ApplicationController
  def new
    @course = Course.find params[:course_id]
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
    @markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, autolink: true, tables: true)
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
    params.require(:exam).permit(:name, :lesson_category_id, :duration)
  end

  def update_params
    params.require(:exam).permit(:name, :duration, :published)
  end

end
