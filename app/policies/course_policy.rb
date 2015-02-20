class CoursePolicy < Struct.new(:user, :course)
  def index?
    user
  end

  def show?
    course.users.include? user
  end

  def settings?
    course.admins.include? user
  end

  def update?
    settings?
  end

  def update_attending?
    course.owners.include? user
  end

  def send_invitation?
    settings?
  end

  def add_user?
    !course.private && user
  end

  def check_password?
    add_user?
  end

  def remove_user?
    update_attending?
  end

  def toggle_flag?
    settings?
  end
end
