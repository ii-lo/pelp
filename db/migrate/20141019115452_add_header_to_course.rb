class AddHeaderToCourse < ActiveRecord::Migration
  def change
    add_column :courses, :header, :string
  end
end
