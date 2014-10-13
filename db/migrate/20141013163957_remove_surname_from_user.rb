class RemoveSurnameFromUser < ActiveRecord::Migration
  def change
    remove_column :users, :surname, :string
  end
end
