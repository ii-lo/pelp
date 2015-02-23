class AddLessonCategoryToExam < ActiveRecord::Migration
  def change
    add_reference :exams, :lesson_category, index: true
  end
end
