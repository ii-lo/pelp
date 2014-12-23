class LessonPolicy < Struct.new(:user, :lesson)
  def new?
    true
    #lesson.course.admins.include? user
  end
  #class Scope
  #end
end
