class AnswerPolicy < Struct.new(:user, :answer)
  def create?
    answer.exam.course.admins.include? user
  end

  def update?
    create?
  end

  def destroy?
    create?
  end
end
