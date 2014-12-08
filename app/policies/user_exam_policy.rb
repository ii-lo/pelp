class UserExamPolicy < Struct.new(:user, :user_exam)
  def show?
    user_exam.user == user && user_exam.closed
  end

  def new?
    user_exam.course.users.include? user

  end

  def start?
    new?
  end
end
