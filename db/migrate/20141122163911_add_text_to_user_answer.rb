class AddTextToUserAnswer < ActiveRecord::Migration
  def change
    add_column :user_answers, :text, :string
  end
end
