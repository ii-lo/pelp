class RemoveLastVisitedFromAttending < ActiveRecord::Migration
  def change
    remove_column :attendings, :last_visited, :datetime
  end
end
