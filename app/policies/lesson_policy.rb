class LessonPolicy < Struct.new(:user, :lesson)
  def new?
    lesson.admins.include? user
  end
  #class Scope
  #end
end
