class ChangeUserExamResultToDecimal < ActiveRecord::Migration
  def change
    change_column :user_exams, :result, :decimal
  end
end
