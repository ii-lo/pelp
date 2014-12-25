class LessonsController < ApplicationController
  before_action :load_course

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
        format.html { redirect_to course_path(@course), notice: "Stworzon lekcję" }
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
        format.html { redirect_to course_path(@course), notice: "Zaaktualizowano lekcję" }
      end
    else
      respond_to do |format|
        format.html { render :edit }
      end
    end
  end

  private

  def load_course
    @course = Course.find params[:course_id]
  end

  def lesson_params
    params.require(:lesson).permit(:name, :lesson_category_id, :content)
  end

end
