class QuestionsController < ApplicationController
  def create
    @exam = Exam.find params[:exam_id]
    @q_c = @exam.question_categories.find params[:question_category_id]
    @question = Question.new(question_params.merge(exam: @exam,
                                                   question_category: @q_c))
    respond_to do |format|
      if @question.save
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
    @q_c = @exam.question_categories.find params[:question_category_id]
    @question = @q_c.questions.find(params[:id])
    @question.destroy
    respond_to do |format|
      format.html do
        redirect_to edit_course_exam_path(@exam.course, @exam),
          notice: "Usunięto"
      end
    end
  end

  private

  def question_params
    params.require(:question).permit(:name, :value, :form)
  end
end
