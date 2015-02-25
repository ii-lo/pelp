class CoursesController < ApplicationController

  before_action :load_course, except: [:index, :new, :create]

  def index
    if params[:query].present?
      p = "%#{params[:query].downcase}%"
      @found_courses = Course.where("LOWER(name) LIKE ? OR
                                    LOWER(description) LIKE ?",
                                    p, p)
      @courses = policy_scope(@found_courses).paginate(page: params[:page], per_page: 16)
    else
      @courses = policy_scope(Course.all).paginate(page: params[:page], per_page: 16)
    end
    authorize(@courses)
  end

  def new
    @course = Course.new
  end

  def create
    @course = Course.new(course_params)
    if @course.save
      @course.attendings.create(user_id: current_user.id, role: 2)
      redirect_to course_path(@course), notice: "Stworzono kurs"
    else
      render :new
    end
  end

  def show
    authorize(@course)
    @lesson_categories = @course.lesson_categories.includes :lessons, :material_categories
    (@exams = policy_scope(@course.exams).group_by(&:lesson_category_id)).default = []
    @admin = @course.admins.include? current_user
    @owner = @course.owners.include? current_user
  end

  def settings
    authorize(@course)
    @users = @course.ordinary_users.paginate(page: params[:page])
    @owner = @course.owners.include? current_user
  end

  def update
    authorize(@course)
    if @course.update_attributes(course_params)
      redirect_to settings_course_path(@course), notice: "Zaakutalizowano"
    else
      render 'settings'
    end
  end

  def destroy
    authorize(@course)
    if params[:course][:name] == @course.name
      @course.destroy
      redirect_to root_path, notice: "Usunięto kurs"
    else
      redirect_to settings_course_path(@course), error: "Nieprawidłowa nazwa"
    end
  end

  def update_attending
    authorize(@course)
    p = params[:attending]
    if p[:user_id].to_i == current_user.id
      return redirect_to settings_course_path(@course),
        notice: "Nie możesz zmienić sobie uprawnień"
    end
    @attending = @course.attendings.where(user_id: p[:user_id]).take
    @attending.update_attribute(:role, p[:role].to_i)
    redirect_to settings_course_path(@course)
  end

  def send_invitation
    authorize(@course)
    @invitation = Invitation.new(
      course_id: @course.id,
      email: params[:invitation][:email],
      user_id: current_user.id
    )

    if @invitation.save
      InvitationMailer.invite(@invitation, request).deliver_later
      respond_to do |format|
        format.html do
          redirect_to settings_course_path(@course),
          notice: "Wysłano mail"
        end
        format.js {  }
        format.json { render json: { valid: true } }
      end
    else
      respond_to do |format|
        format.json do
          render json: { errors: @invitation.errors.full_messages.join("\n") },
            status: 422
        end
        format.html do
          flash[:error] =  @invitation.errors.full_messages
          redirect_to settings_course_path(@course)
        end
      end
    end
  end

  def add_user
    authorize(@course)
    if @course.users.include? current_user
      return redirect_to course_path(@course)
    end
    if @course.password.blank?
      @course.attendings.create(user_id: current_user.id)
      return redirect_to course_path(@course)
    end
  end

  def check_password
    authorize(@course)
    if params[:course][:password] == @course.password
      @course.attendings.create(user_id: current_user.id)
      redirect_to course_path(@course), notice: "Dodano do kursu"
    else
      flash.now[:error] = "Nieprawidłowe hasło"
      render :add_user
    end
  end

  def remove_user
    authorize(@course)
    @user = User.find params[:user_id]
    if @user == current_user
      return redirect_to settings_course_path(@course),
        notice: "Tylko inny właściciel może usunąć cię z kursu"
    end
    Attending.where(course_id: @course, user_id: @user).destroy_all
    redirect_to settings_course_path(@course)
  end

  def remove_self
    authorize(@course)
    Attending.where(course_id: @course, user_id: current_user).
      destroy_all
    redirect_to root_path, notice: "Usunięto z kursu"
  end

  def toggle_flag
    authorize(@course)
    @l_c = @course.lesson_categories.find params[:lesson_category_id]
    @l_c.update_attribute(:flagged, !@l_c.flagged)
    respond_to do |format|
      format.html { redirect_to course_path(@course) }
      format.json { render json: { id: @l_c.id, flagged: @l_c.flagged } }
    end
  end

  private

  def load_course
    @course = Course.find(params[:id])
    if at = Attending.where(course_id: @course.id, user_id: current_user.id).first
      at.update_last_visit
    end
  end

  def course_params
    params.require(:course).permit(
      :name, :description, :password, :private
    )
  end

end
