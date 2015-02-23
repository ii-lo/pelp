class AddFormToQuestion < ActiveRecord::Migration
  def change
    add_column :questions, :form, :integer, default: 0
  end
end
