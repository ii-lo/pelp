class AddClosedToUserExam < ActiveRecord::Migration
  def change
    add_column :user_exams, :closed, :boolean, default: false
  end
end
