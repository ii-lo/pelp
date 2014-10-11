class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.string :name
      t.boolean :correct, default: false
      t.belongs_to :question, index: true

      t.timestamps
    end
  end
end
