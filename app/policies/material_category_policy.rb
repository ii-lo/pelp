class MaterialCategoryPolicy < Struct.new(:user, :m_c)
  def show?
    m_c.course.users.include? user
  end

  def create?
    m_c.course.admins.include? user
  end

  def update?
    create?
  end

  def destroy?
    create?
  end

  def new?
    create?
  end
end
