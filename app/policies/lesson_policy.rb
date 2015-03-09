class LessonPolicy < Struct.new(:user, :lesson)
  def new?
    lesson.course.admins.include? user
  end

  def show?
    lesson.course.users.include? user
  end

  def create?
    new?
  end

  def edit?
    new?
  end

  def update?
    new?
  end

  def destroy?
    new?
  end
end
