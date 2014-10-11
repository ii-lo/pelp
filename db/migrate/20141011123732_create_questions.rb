class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.belongs_to :exam, index: true
      t.string :name
      t.integer :value

      t.timestamps
    end
  end
end
