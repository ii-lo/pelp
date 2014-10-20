class DropLastVisitsTable < ActiveRecord::Migration
  def change
    drop_table :last_visits
  end
end
