class AddPrivateToCourse < ActiveRecord::Migration
  def change
    add_column :courses, :private, :boolean, default: false
  end
end
