class AddFlaggedToLessonCategory < ActiveRecord::Migration
  def change
    add_column :lesson_categories, :flagged, :boolean, default: false
  end
end
