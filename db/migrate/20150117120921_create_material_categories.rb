class CreateMaterialCategories < ActiveRecord::Migration
  def change
    create_table :material_categories do |t|
      t.belongs_to :lesson_category, index: true
      t.string :name

      t.timestamps null: false
    end
    add_foreign_key :material_categories, :lesson_categories
  end
end
