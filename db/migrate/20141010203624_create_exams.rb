class CreateExams < ActiveRecord::Migration
  def change
    create_table :exams do |t|
      t.string :name
      t.belongs_to :course, index: true

      t.timestamps
    end
  end
end
