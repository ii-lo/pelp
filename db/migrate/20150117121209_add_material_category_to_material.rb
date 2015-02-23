class AddMaterialCategoryToMaterial < ActiveRecord::Migration
  def change
    add_reference :materials, :material_category, index: true
    add_foreign_key :materials, :material_categories
    remove_reference :materials, :lesson_category
  end
end
