class MaterialPolicy < Struct.new(:user, :material)
  def create?
    material.course.admins.include? user
  end

  def destroy?
    create?
  end
end
