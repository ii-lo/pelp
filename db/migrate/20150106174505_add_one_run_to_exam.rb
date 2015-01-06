class AddOneRunToExam < ActiveRecord::Migration
  def change
    add_column :exams, :one_run, :boolean, default: false
  end
end
