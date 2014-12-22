class ExamPolicy < Struct.new(:user, :exam, :course)
  #TODO: Real courses policies
  def new?
    exam.course.users.include? user
  end

  def create?
    new?
  end

  #class Scope
    #attr_reader :user, :scope
    #def initialize(user, scope)
      #@user, @scope
    #end

    #def resolve
    #end
  #end

end
