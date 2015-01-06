class UserExamPolicy < Struct.new(:user, :user_exam)
  def show?
    user_exam.user == user && user_exam.closed
  end

  def new?
    return false unless check_if_one_run
    user_exam.course.users.include? user
  end

  def start?
    new?
  end

  def exit?
    user_exam.user == user
  end

  def question?
    return false unless check_if_one_run(1)
    user_exam.user == user
  end

  def answer?
    question?
  end

  private

  def check_if_one_run(max_length = 0)
    if user_exam.exam.one_run &&
    user.user_exams.where(exam_id: user_exam.exam_id).size > max_length
      false
    else
      true
    end
  end
end
