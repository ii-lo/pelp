class CreateInvitations < ActiveRecord::Migration
  def change
    create_table :invitations do |t|
      t.belongs_to :course, index: true
      t.belongs_to :user, index: true
      t.string :email

      t.timestamps null: false
    end
    add_foreign_key :invitations, :courses
    add_foreign_key :invitations, :users
  end
end
