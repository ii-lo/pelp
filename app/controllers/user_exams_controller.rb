class UserExamsController < ApplicationController
  def new
    @exam = Exam.find params[:id]
    @user_exam = @exam.user_exams.create!(user_id: current_user.id)
    session[:result] = 0
    session[:user_exam_id] = @user_exam.id
    session[:user_exam_questions] = @exam.questions.pluck(:id).
      shuffle
    session[:user_exam_questions_count] = @exam.questions.size
    session[:max_point] = @exam.questions.sum(:value)
    redirect_to question_user_exam_path
  end

  def question
    @user_exam = UserExam.find session[:user_exam_id]
    @question = Question.find session[:user_exam_questions].first
    session[:current_question_id] = @question.id
  end

  def answer
    @question = Question.find session[:current_question_id]
    if @question.answers.find(params[:answer][:id]).correct
      session[:result] += @question.value
    end
    session[:user_exam_questions].shift
    if session[:user_exam_questions].any?
      redirect_to question_user_exam_path
    else
      result = session[:result]
      max = session[:max_point]
      [:user_exam_id, :user_exam_questions, :user_exam_questions_count, :result, :max_point].each do |s|
        session.delete s
      end
      redirect_to course_path(@question.exam.course.id), notice: "Twój wynik to #{result}/#{max} pkt."
    end
  end
end
