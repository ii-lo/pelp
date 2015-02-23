class LessonCategoriesController < ApplicationController
  before_action :load_lesson_category, except: :create

  def create
    @course = Course.find params[:course_id]
    @lesson_category = @course.lesson_categories.build(create_params)
    authorize(@lesson_category)
    if @lesson_category.save
      redirect_to settings_course_path(@course), notice: "Stworzono"
    else
      redirect_to settings_course_path(@course), notice: "Błąd"
    end
  end

  def destroy
    authorize(@lesson_category)
    @lesson_category.destroy
    redirect_to settings_course_path(@course),
      notice: "Usunięto kategorię"
  end

  def update
    authorize(@lesson_category)
    if @lesson_category.update_attributes(update_params)
      respond_to do |format|
        format.html do
          redirect_to settings_course_path(@course),
            notice: "Zaaktualizowano"
        end
        format.json do
          render json: {
            lesson_category: {
              id: @lesson_category.id,
              name: @lesson_category.name
            }
          }
        end
      end
    else
      respond_to do |format|
        format.html do
          redirect_to settings_course_path(@course),
            error: @lesson_category.errors.full_messages
        end
        format.json do
          render json: {
            errors: @lesson_category.errors.full_messages
          }, status: 422
        end
      end
    end
  end
  private

  def load_lesson_category
    @course = Course.find params[:course_id]
    @lesson_category = @course.lesson_categories.find(params[:id])
  end

  def create_params
    params.require(:lesson_category).permit(:name, :flagged)
  end

  def update_params
    params.require(:lesson_category).permit(:name)
  end

end
