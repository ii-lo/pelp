class AddLastVisitToAttending < ActiveRecord::Migration
  def change
    add_column :attendings, :last_visit, :datetime
  end
end
