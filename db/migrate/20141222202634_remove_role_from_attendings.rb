class RemoveRoleFromAttendings < ActiveRecord::Migration
  def change
    remove_column :attendings, :role_id, :integer
  end
end
