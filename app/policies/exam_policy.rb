class ExamPolicy < Struct.new(:user, :exam)
  def new?
    exam && exam.course.admins.include?(user)
  end

  def create?
    new?
  end

  class Scope
    attr_reader :user, :scope
    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      scope.where(
        "('exams'.'published' = ? AND 'exams'.'course_id' IN(?)) OR
         ('exams'.'published' = ? AND 'exams'.'course_id' IN(?))",
         false, user.admin_courses.select(:id),
         true, user.courses.select(:id)
      )
    end
  end

end
