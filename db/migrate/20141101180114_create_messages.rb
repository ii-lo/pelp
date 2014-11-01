class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.belongs_to :sender, index: true
      t.belongs_to :receiver, index: true
      t.string :topic
      t.string :body

      t.timestamps
    end
  end
end
