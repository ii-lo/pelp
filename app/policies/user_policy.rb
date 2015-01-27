class UserPolicy < Struct.new(:current_user, :user)
  def show?
    current_user
  end

  def create?
    !current_user
  end

  def new?
    create?
  end

  def edit?
    current_user == user
  end

  def update?
    edit?
  end

  def change_password?
    edit?
  end

  def destroy?
    edit?
  end
end
