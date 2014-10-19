class AddThumbToCourse < ActiveRecord::Migration
  def change
    add_column :courses, :thumb, :string
  end
end
