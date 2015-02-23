class AddRoleValueToAttending < ActiveRecord::Migration
  def change
    add_column :attendings, :role, :integer, default: 0
  end
end
