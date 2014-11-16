class ChangeLessonsRelations < ActiveRecord::Migration
  def change
    add_reference :lessons, :lesson_category, index: true
    remove_column :lessons, :course_id, :integer
  end
end
