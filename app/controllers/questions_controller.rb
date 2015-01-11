class QuestionsController < ApplicationController
  def create
    @exam = Exam.find params[:exam_id]
    @q_c = @exam.question_categories.find params[:question_category_id]
    @question = Question.new(question_params.merge(exam: @exam,
                                                   question_category: @q_c))
    authorize(@question)
    respond_to do |format|
      if @question.save
        format.html do
          redirect_to edit_course_exam_path(@exam.course, @exam),
            notice: "Stworzono"
        end
        format.js do
          @markdown = markdown_renderer
        end
        format.json { render json: @question }
      else
        format.json { render json: { errors: @question.errors.full_messages }, status: 422  }
        format.html do
          redirect_to edit_course_exam_path(@exam.course, @exam),
            notice: "Jakiś błąd"
        end
      end
    end
  end

  def update
    @exam = Exam.find params[:exam_id]
    @question = @exam.questions.find params[:id]
    authorize(@question)
    if @question.update_attributes(update_params)
      respond_to do |format|
        format.html { redirect_to :back, notice: "Zaaktualizowano" }
        format.json { render json: @question }
      end
    else
      respond_to do |format|
        format.html { redirect_to :back, error: @question.errors.full_messages }
        format.json { render json: { errors: @question.errors.full_messages }, status: 422 }
      end
    end
  end

  def destroy
    @exam = Exam.find params[:exam_id]
    @q_c = @exam.question_categories.find params[:question_category_id]
    @question = @q_c.questions.find(params[:id])
    authorize(@question)
    @question.destroy
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

  def get_markdown
    @question = Question.find params[:id]
    authorize(@question)
    @markdown = markdown_renderer.call(@question.name)[:output].to_s
    render layout: false
  end

  private

  def question_params
    params.require(:question).permit(:name, :value, :form, :picture)
  end

  def update_params
    params.require(:question).permit(:name, :value, :picture, :delete_picture)
  end
end
