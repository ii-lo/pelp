class UsersController < ApplicationController
  def new
    @user ||= User.new
  end

  def create
    # yeah...
    params[:user][:password_confirmation] = params[:user][:password]
    @user = User.new user_params
    respond_to do |format|
      if @user.save
        format.html { redirect_to root_path, notice: "Zarejestrowano" }
      else
        format.html { render 'new' }
      end
    end
  end

  def show
  end

  def edit
  end

  def update
  end

  def destroy
  end

  def dashboard
    @user = current_user
    @courses = @user.last_visited_courses.paginate(page: params[:page], per_page: 30)
  end

  private

  def user_params
    params.require(:user).permit(:email, :name, :password,
                                :password_confirmation)
  end
end
