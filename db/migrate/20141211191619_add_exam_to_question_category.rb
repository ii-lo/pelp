class AddExamToQuestionCategory < ActiveRecord::Migration
  def change
    add_reference :question_categories, :exam, index: true
  end
end
