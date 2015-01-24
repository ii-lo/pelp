class PicturesController < ApplicationController
  def create
    @lesson = Lesson.find params[:lesson_id]
    @picture = @lesson.pictures.build(picture_params)
    if @picture.save
      redirect_to edit_course_lesson_path(@lesson.course, @lesson),
        notice: "Stworzono"
    else
      redirect_to edit_course_lesson_path(@lesson.course, @lesson),
        notice: "Wystąpił błąd"
    end
  end

  def destroy
    @picture = Picture.find(params[:id])
    @lesson = @picture.lesson
    @picture.destroy
    redirect_to edit_course_lesson_path(@lesson.course, @lesson),
      notice: "Usunięto"
  end

  private

  def picture_params
    params.require(:picture).permit(:description, :file)
  end
end
