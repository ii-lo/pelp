class AddFlaggedToMessages < ActiveRecord::Migration
  def change
    add_column :messages, :flagged, :boolean, default: false
  end
end
