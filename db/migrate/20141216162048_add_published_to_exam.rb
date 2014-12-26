class AddPublishedToExam < ActiveRecord::Migration
  def change
    add_column :exams, :published, :boolean, default: false
  end
end
