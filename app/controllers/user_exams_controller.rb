class UserExamsController < ApplicationController
  def new
    @exam = Exam.find params[:id]
    @user_exam = @exam.user_exams.create!(user_id: current_user.id)
    prepare_session
    redirect_to question_user_exam_path
  end

  def question
    @user_exam = UserExam.find session[:user_exam_id]
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
    end
    session[:user_exam_questions].shift
    if session[:user_exam_questions].any?
      redirect_to question_user_exam_path
    else
      @user_exam = UserExam.find session[:user_exam_id]
      @user_exam.update_attribute(:result, session[:result])
      clear_session
      redirect_to course_path(@question.exam.course.id), notice: "Twój wynik to #{@user_exam.result} pkt."
    end
  end

  private

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
    [:user_exam_id, :user_exam_questions, :user_exam_questions_count, :result].each do |s|
      session.delete s
    end
  end
end
