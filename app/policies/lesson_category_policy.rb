class LessonCategoryPolicy < Struct.new(:user, :lesson_category)
  def destroy?
    lesson_category.course.owners.include? user
  end

  def create?
    destroy?
  end

  def update?
    destroy?
  end
end
