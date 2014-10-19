class AddRelationToLastVisit < ActiveRecord::Migration
  def change
    add_reference :last_visits, :relation, polymorphic: true, index: true
  end
end
