class AnswersController < ApplicationController
  def create
    @question = Question.find params[:question_id]
    @answer = @question.answers.build(answer_params)
    @exam = @question.exam
    respond_to do |format|
      if @answer.save
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
    @question = Question.find params[:question_id]
    @answer = @question.answers.find(params[:id])
    @exam = @question.exam
    @answer.destroy
    respond_to do |format|
      format.html do
        redirect_to edit_course_exam_path(@exam.course, @exam),
          notice: "Usunięto"
      end
    end
  end

  private

  def answer_params
    params.require(:answer).permit(:name, :correct)
  end
end
