class QuestionPolicy < Struct.new(:user, :question)
  def create?
    question.exam.course.admins.include? user
  end

  def update?
    create?
  end

  def destroy?
    create?
  end

  def get_markdown?
    create?
  end

end
