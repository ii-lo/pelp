class MaterialsController < ApplicationController
  def create
    @m_c = MaterialCategory.find params[:material_category_id]
    @material = @m_c.materials.build(material_params)
    authorize(@material)
    if @material.save
      redirect_to course_material_category_path(@m_c.course, @m_c),
        notice: "Stworzono"
    else
      redirect_to course_material_category_path(@m_c.course, @m_c),
        error: "Błąd"
    end
  end

  def destroy
    @material = Material.find params[:id]
    @m_c = @material.material_category
    authorize(@material)
    if @material.destroy
      redirect_to course_material_category_path(@m_c.course, @m_c),
        notice: "Usunięto"
    else
      redirect_to course_material_category_path(@m_c.course, @m_c),
        error: "Błąd"
    end
  end

  private

  def material_params
    params.require(:material).permit(:name, :file)
  end
end
