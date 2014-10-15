class AddLastVisitedToAttending < ActiveRecord::Migration
  def change
    add_column :attendings, :last_visited, :datetime
  end
end
