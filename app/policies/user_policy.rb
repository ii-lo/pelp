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
end
