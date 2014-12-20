class QuestionCategoriesController < ApplicationController
  def create
    @exam = Exam.find params[:exam_id]
    @q_c = @exam.question_categories.build(q_c_params)
    respond_to do |format|
      if @q_c.save
        format.html do
          redirect_to edit_course_exam_path(@exam.course, @exam),
          notice: "Stworzono"
        end
      else
        format.html do
          redirect_to edit_course_exam_path(@exam.course, @exam),
          notice: "Jakiś błąd"
        end
      end
    end
  end

  def destroy
    @exam = Exam.find params[:exam_id]
    @q_c = @exam.question_categories.find params[:id]
    @q_c.destroy
    respond_to do |format|
      format.html do
        redirect_to edit_course_exam_path(@exam.course, @exam),
          notice: "Usunięto"
      end
    end
  end

  private

  def q_c_params
    params.require(:question_category).permit(:name)
  end
end
