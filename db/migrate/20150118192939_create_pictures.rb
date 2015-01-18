class CreatePictures < ActiveRecord::Migration
  def change
    create_table :pictures do |t|
      t.string :slug
      t.string :description, default: ''
      t.belongs_to :lesson, index: true

      t.timestamps null: false
    end
    add_foreign_key :pictures, :lessons
  end
end
