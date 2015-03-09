class UserExamAnswerFacade
  attr_reader :params, :session
  def initialize(params, session)
    @params = params
    @params[:answer] ||= {}
    @session = session
    @question = Question.find session[:current_question_id]
  end

  def rate!
    case @question.form
    when 'single'
      single_answer
    when 'multiple'
      multiple_answer
    when 'open'
      open_answer
    # else
      # fail ArgumentError, 'invalid question type'
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
    ids = params[:answer].fetch(:id) { [nil] }
    correct, wrong = 0, 0
    ids.each do |i|
      u = UserAnswer.create(user_exam_id: session[:user_exam_id],
                            answer_id: i, question_id: @question.id)
      next if i.to_i.zero?
      u.correct ? correct += 1 : wrong += 1
    end
    diff = correct > wrong ? correct - wrong : 0
    session[:result] += (diff.to_f) * @question.value / @question.correct_answers.size
  end

  def open_answer
    text = params[:answer].fetch(:text) { ' ' }
    u = UserAnswer.create(user_exam_id: session[:user_exam_id],
                          text: text, question_id: @question.id)
    session[:result] += @question.value if u.correct
  end
end
