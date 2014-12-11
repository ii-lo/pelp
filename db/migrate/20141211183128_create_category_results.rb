class CreateCategoryResults < ActiveRecord::Migration
  def change
    create_table :category_results do |t|
      t.belongs_to :user_exam, index: true
      t.belongs_to :category, index: true
      t.decimal :value, default: 0

      t.timestamps
    end
  end
end
