class CreateMaterials < ActiveRecord::Migration
  def change
    create_table :materials do |t|
      t.belongs_to :lesson_category, index: true
      t.string :name

      t.timestamps null: false
    end
    add_foreign_key :materials, :lesson_categories
  end
end
