class AddQuestionCategoryToQuestion < ActiveRecord::Migration
  def change
    add_reference :questions, :question_category, index: true
  end
end
