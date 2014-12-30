class ExamPolicy < Struct.new(:user, :exam)
  def new?
    #binding.pry
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
         false, user.admin_courses.pluck(:id),
         true, user.courses.pluck(:id)
      )
    end
  end

end
