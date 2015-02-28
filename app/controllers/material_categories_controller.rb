class MaterialCategoriesController < ApplicationController
  invisible_captcha only: [:create, :update]
  before_action :load_course
  before_action :load_lesson_category

  def create
    @m_c = MaterialCategory.new(material_category_params)
    authorize(@m_c)
    if @m_c.save
      redirect_to course_material_category_path(@m_c.course, @m_c)
    else
      render 'new'
    end
  end

  def new
    @m_c = MaterialCategory.new
    @m_c.course = @course
    authorize(@m_c)
  end

  def destroy
    @m_c = MaterialCategory.find params[:id]
    authorize(@m_c)
    if @m_c.destroy
      redirect_to course_material_category_path(@m_c.course, @m_c),
        notice: "Usunięto"
    else
      redirect_to course_material_category_path(@m_c.course, @m_c),
        error: "Błąd"
    end
  end

  def update
    @m_c = MaterialCategory.find params[:id]
    authorize(@m_c)
    if @m_c.update_attributes(material_category_params)
      redirect_to course_material_category_path(@m_c.course, @m_c), notice: "Zaaktualizowano"
    else
      render :show
    end
  end

  def show
    @m_c = MaterialCategory.find params[:id]
    authorize(@m_c)
    @course = @m_c.course
    @materials = @m_c.materials
  end

  private

  def load_course
    @course = Course.find params[:course_id]
  end

  def material_category_params
    params.require(:material_category).permit(:name, :lesson_category_id)
  end

  def load_lesson_category
    if params[:lesson_category_id]
      @l_c = @course.lesson_categories.find(params[:lesson_category_id])
    else
      @l_c = nil
    end
  end
end
