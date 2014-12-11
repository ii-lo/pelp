class UserExamsController < ApplicationController
  before_action :check_if_closed, only: [:answer, :question]

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
    @user_exam.close!
    clear_session
    show_result
  end

  def question
    @question = Question.find session[:user_exam_questions].first
    @exam = @question.exam
    session[:current_question_id] = @question.id
  end

  def answer
    @question = Question.find session[:current_question_id]
    params[:answer] ||= {}
    case @question.form
      when 'single'
        single_answer
      when 'multiple'
        multiple_answer
      when 'open'
        open_answer
      else
        raise ArgumentError, 'invalid question type'
    end
    session[:user_exam_questions].shift
    if session[:user_exam_questions].any?
      redirect_to question_user_exam_path
    else
      @user_exam.close!
      clear_session
      show_result
    end
  end

  private

  def show_result
    redirect_to user_exam_path(@user_exam)
  end

  def single_answer
    id = params[:answer][:id]
    u = UserAnswer.create(user_exam_id: session[:user_exam_id],
                          answer_id: id, question_id: @question.id)
    session[:result] += @question.value if u.correct
  end

  def multiple_answer
    ids = params[:answer][:id] || [nil]
    correct, wrong = 0, 0
    ids.each do |i|
      u = UserAnswer.create(user_exam_id: session[:user_exam_id],
                            answer_id: i, question_id: @question.id)
      u.correct ? correct += 1 : wrong += 1
    end
    diff = correct > wrong ? correct - wrong : 0
    session[:result] += (diff.to_f) * @question.value / @question.correct_answers.size
  end

  def open_answer
    text = params[:answer][:text] || ''
    u = UserAnswer.create(user_exam_id: session[:user_exam_id],
                          text: text, question_id: @question.id)
    session[:result] += @question.value if u.correct
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
    @exam = @user_exam.exam
    if Time.now > @user_exam.created_at + @exam.duration
      @user_exam.close!
    end
    if @user_exam.closed
      clear_session
      return show_result
    end
  end
end
