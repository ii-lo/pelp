class AddMaxPointsToExam < ActiveRecord::Migration
  def change
    add_column :exams, :max_points, :integer, default: 0
  end
end
