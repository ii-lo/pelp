class AddQuestionToUserAnswer < ActiveRecord::Migration
  def change
    add_reference :user_answers, :question, index: true
  end
end
