class LessonPolicy < Struct.new(:user, :lesson)
  def new?
    #lesson.course.admins.include? user
  end
  #class Scope
  #end
end
