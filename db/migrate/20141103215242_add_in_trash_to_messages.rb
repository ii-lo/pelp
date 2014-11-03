class AddInTrashToMessages < ActiveRecord::Migration
  def change
    add_column :messages, :in_trash, :boolean, default: false
  end
end
