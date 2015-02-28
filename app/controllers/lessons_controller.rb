class LessonsController < ApplicationController
  invisible_captcha only: [:create, :update]
  before_action :load_course
  before_action :load_lesson_category, except: [:show]

  def show
    @lesson = @course.lessons.find params[:id]
    @markdown = markdown_renderer.call(@lesson.content)[:output].to_s
    authorize(@lesson)
  end

  def new
    @lesson = @course.lessons.build
    authorize(@lesson)
  end

  def create
    @lesson = @course.lessons.build(lesson_params)
    authorize(@lesson)
    if @lesson.save
      respond_to do |format|
        format.html { redirect_to course_lesson_path(@course, @lesson), notice: "Stworzon lekcję" }
      end
    else
      respond_to do |format|
        format.html { render :new }
      end
    end
  end

  def edit
    @lesson = @course.lessons.find(params[:id])
    authorize @lesson
  end

  def update
    @lesson = @course.lessons.find params[:id]
    authorize @lesson
    if @lesson.update_attributes(lesson_params)
      respond_to do |format|
        format.html { redirect_to course_lesson_path(@course, @lesson), notice: "Zaaktualizowano lekcję" }
      end
    else
      respond_to do |format|
        format.html { render :edit }
      end
    end
  end

  def destroy
    @lesson = @course.lessons.find(params[:id])
    authorize(@lesson)
    @lesson.destroy
    redirect_to course_path(@course), notice: "Usunięto"
  end

  private

  def load_course
    @course = Course.find params[:course_id]
  end

  def lesson_params
    params.require(:lesson).permit(:name, :lesson_category_id, :content)
  end

  def load_lesson_category
    if params[:lesson_category_id]
      @l_c = @course.lesson_categories.find(params[:lesson_category_id])
    else
      @l_c = nil
    end
  end

end
