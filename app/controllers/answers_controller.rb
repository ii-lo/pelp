class AnswersController < ApplicationController
  def create
    @question = Question.find params[:question_id]
    @answer = @question.answers.build(answer_params)
    @exam = @question.exam
    authorize(@answer)
    if @answer.save
      respond_to do |format|
        format.html do
          redirect_to edit_course_exam_path(@exam.course, @exam),
            notice: "Stworzono"
        end
        format.js {  }
        format.json { render json: @answer }
      end
    else
      respond_to do |format|
        format.json { render json: { errors: @answer.errors.full_messages }, status: 422 }
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
    authorize(@answer)
    @answer.destroy
    respond_to do |format|
      format.json do
        render json: { destroyed: true }
      end
      format.html do
        redirect_to edit_course_exam_path(@exam.course, @exam),
          notice: "Usunięto"
      end
    end
  end

  def update
    @question = Question.find params[:question_id]
    @answer = @question.answers.find params[:id]
    authorize(@answer)
    if @answer.update_attributes(answer_params)
      respond_to do |format|
        format.html { redirect_to :back, notice: "Zaaktualizowano" }
        format.json { render json: @answer }
      end
    else
      respond_to do |format|
        format.html { redirect_to :back, error: @answer.errors.full_messages }
        format.json { render json: { errors: @answer.errors.full_messages }, status: 422 }
      end
    end
  end

  private

  def answer_params
    params.require(:answer).permit(:name, :correct)
  end
end
