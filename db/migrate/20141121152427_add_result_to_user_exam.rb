class AddResultToUserExam < ActiveRecord::Migration
  def change
    add_column :user_exams, :result, :integer, default: 0
  end
end
