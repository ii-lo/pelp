class DropMessagesTable < ActiveRecord::Migration
  def change
    drop_table :messages
    drop_table :sendings
  end
end
