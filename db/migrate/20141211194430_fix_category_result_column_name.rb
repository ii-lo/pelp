class FixCategoryResultColumnName < ActiveRecord::Migration
  def change
    rename_column :category_results, :category_id, :question_category_id
  end
end
