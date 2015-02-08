class UserExamsController < ApplicationController
  before_action :check_if_closed, only: [:answer, :question]
  # also loads @user_exam

  def show
    @user_exam = UserExam.find params[:id]
    authorize @user_exam
    @exam = @user_exam.exam
    @answers = @user_exam.user_answers.includes(:question)
    @category_results = @user_exam.category_results.includes :question_category
  end

  def new
    @exam = Exam.find params[:id]
  end

  def start
    @exam = Exam.find params[:id]
    @user_exam = @exam.user_exams.create!(user_id: current_user.id)
    authorize @user_exam
    prepare_session
    redirect_to question_user_exam_path
    @user_exam.wait_for_close!
  end

  def exit
    @user_exam = UserExam.find session[:user_exam_id]
    authorize @user_exam
    @user_exam.close!
    clear_session
    show_result
  end

  def question
    authorize @user_exam
    @question = Question.find session[:user_exam_questions].first
    @exam = @question.exam
    @markdown = markdown_renderer.call(@question.name)[:output].to_s
    @end_time = @user_exam.created_at + @exam.duration
    session[:current_question_id] = @question.id
  end

  def answer
    authorize @user_exam
    UserExamAnswerFacade.new(params, session).rate!
    session[:user_exam_questions].shift
    if session[:user_exam_questions].any?
      redirect_to question_user_exam_path
    else
      @user_exam.close!
      clear_session
      show_result
    end
  end

  def edit
    @user_exam = UserExam.find params[:id]
    authorize @user_exam
    @exam = @user_exam.exam
    @markdown = markdown_renderer
    @u_e_f = UserExamFacade.new(@user_exam)
    @q_cs = @exam.question_categories.includes(:questions, :answers)
  end

  def correct_answer
    @user_exam = UserExam.find(params[:id])
    authorize(@user_exam)
    @user_answer = @user_exam.user_answers.find(params[:user_answers_id])
    redirect_to edit_user_exam_path(@user_exam), notice: "Poprawiono"
  end

  private

  def show_result
    redirect_to user_exam_path(@user_exam)
  end

  def prepare_session
    session[:result] ||= 0.0
    session[:user_exam_id] ||= @user_exam.id
    session[:user_exam_questions] ||= @exam.questions.pluck(:id).
        shuffle
    session[:user_exam_questions_count] ||= @exam.questions.size
  end

  def clear_session
    [:user_exam_id, :user_exam_questions, :user_exam_questions_count, :result, :current_question_id].each do |s|
      session.delete s
    end
  end

  def check_if_closed
    @user_exam = UserExam.find_by_id session[:user_exam_id]
    return redirect_to root_path unless @user_exam
    if @user_exam.closed
      clear_session
      return show_result
    elsif Time.now > @user_exam.created_at + @user_exam.exam_duration
      @user_exam.close!
      clear_session
      return show_result
    end
  end

end
