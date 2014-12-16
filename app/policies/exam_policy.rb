class ExamPolicy < Struct.new(:user, :exam, :course)
  #TODO: Real courses policies
  def new?
    exam.course.users.include? user
  end

  def create?
    new?
  end
end
