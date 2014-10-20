class AddRoleToAttending < ActiveRecord::Migration
  def change
    add_reference :attendings, :role, index: true
  end
end
