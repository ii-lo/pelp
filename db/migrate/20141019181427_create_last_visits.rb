class CreateLastVisits < ActiveRecord::Migration
  def change
    create_table :last_visits do |t|
      t.belongs_to :user, index: true
      t.belongs_to :course, index: true
      t.datetime :date

      t.timestamps
    end
  end
end
