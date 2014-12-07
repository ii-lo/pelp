class CreateUserAnswers < ActiveRecord::Migration
  def change
    create_table :user_answers do |t|
      t.belongs_to :answer, index: true
      t.belongs_to :user_exam, index: true
      t.boolean :correct

      t.timestamps
    end
  end
end
