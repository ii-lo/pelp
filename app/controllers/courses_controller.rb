class CoursesController < ApplicationController

  before_action :load_course, except: [:index]

  def index
    @courses = Course.open.paginate(page: params[:page], per_page: 16)
    authorize(@courses)
  end

  def show
    authorize(@course)
    @lesson_categories = @course.lesson_categories.includes :lessons
    (@exams = policy_scope(@course.exams).group_by(&:lesson_category_id)).default = []
    @admin = @course.admins.include? current_user
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

  def update_attending
    authorize(@course)
    p = params[:attending]
    if p[:user_id] == current_user.id
      return redirect_to :back,
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

  private

  def load_course
    @course = Course.find(params[:id])
    if at = Attending.where(course_id: @course.id, user_id: current_user.id).first
      at.update_last_visit
    end
  end

  def course_params
    params.require(:course).permit(:name, :description)
  end

end
