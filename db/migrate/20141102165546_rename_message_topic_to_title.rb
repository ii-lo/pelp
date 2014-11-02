class RenameMessageTopicToTitle < ActiveRecord::Migration
  def change
    rename_column :messages, :topic, :title
  end
end
