class AddCorrectAnswersCountToQuestion < ActiveRecord::Migration
  def change
    add_column :questions, :correct_answers_count, :integer, default: 0
  end
end
