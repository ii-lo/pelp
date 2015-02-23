class AddContentToLesson < ActiveRecord::Migration
  def change
    add_column :lessons, :content, :text, default: ''
  end
end
