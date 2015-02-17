class UsersController < ApplicationController
  def new
    @user ||= User.new
    authorize(@user)
  end

  def create
    authorize(:user)
    params[:user][:password_confirmation] ||= params[:user][:password]
    @user = User.new user_params
    respond_to do |format|
      if @user.save
        sign_in @user, bypass: true
        format.html { redirect_to root_path, notice: "Zarejestrowano" }
      else
        format.html { render 'new' }
      end
    end
  end

  def show
    @user = User.find params[:id]
    authorize(@user)
    @courses = @user.admin_courses.paginate(page: params[:page], per_page: 8)
  end

  def edit
    @user = User.find params[:id]
    authorize(@user)
  end

  def update
    @user = User.find params[:id]
    authorize(@user)
    unless @user.valid_password?(params[:user][:current_password])
      flash.now[:error] = "Nieprawidłowe hasło"
      return render :edit
    end
    if @user.update_attributes(update_params)
      sign_in @user, bypass: true
      redirect_to edit_user_path(@user), notice: "Zaaktualizowano"
    else
      render :edit
    end
  end

  def change_password
    @user = User.find params[:id]
    authorize(@user)
    unless @user.valid_password?(params[:user][:current_password])
      flash.now[:error] = "Nieprawidłowe hasło"
      return render :edit
    end
    if @user.update_attributes(password_params)
      sign_in @user, bypass: true
      redirect_to edit_user_path(@user), notice: "Zmieniono hasło"
    else
      render :edit
    end
  end

  def destroy
    @user = User.find params[:id]
    authorize(@user)
    unless @user.valid_password?(params[:user][:current_password])
      flash.now[:error] = "Nieprawidłowe hasło"
      return render :edit
    end
    @user.destroy
    redirect_to root_path, notice: "Usunięto konto"
  end

  def dashboard
    @user = current_user
    @courses = @user.last_visited_courses.paginate(page: params[:page], per_page: 12)
  end

  private

  def user_params
    params.require(:user).permit(:email, :name, :password,
                                 :password_confirmation)
  end

  def update_params
    params.require(:user).permit(:name, :email, :location, :company,
                                 :contact_mail, :home_url, :note)
  end

  def password_params
    params.require(:user).permit(:password, :password_confirmation)
  end
end
