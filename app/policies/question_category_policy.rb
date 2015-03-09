class QuestionCategoryPolicy < Struct.new(:user, :question_category)
  def create?
    question_category.exam.course.admins.include? user
  end

  def update?
    create?
  end

  def destroy?
    create?
  end
end
