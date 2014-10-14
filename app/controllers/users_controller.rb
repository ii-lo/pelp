class UsersController < ApplicationController
  def new
    @user ||= User.new
  end

  def create
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
    
  end

  private

  def user_params
    params.require(:user).permit(:email, :name, :password,
                                :password_confirmation)
  end
end
