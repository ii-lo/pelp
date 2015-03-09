class UserExamFacade
  attr_reader :user_exam, :data
  def initialize(user_exam)
    @user_exam = user_exam
    prepare_data
  end

  private

  def prepare_data
    @data = {}
    @user_exam.user_answers.includes(:question_category, :question).each do |ua|
      @data[ua.question_category.id] ||= {}
      @data[ua.question_category.id][ua.question_id] ||= []
      @data[ua.question_category.id][ua.question_id] << ua
    end
  end
end
