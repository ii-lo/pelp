class AddDetailsToUser < ActiveRecord::Migration
  def change
    add_column :users, :location, :string
    add_column :users, :company, :string
    add_column :users, :contact_mail, :string
    add_column :users, :home_url, :string
    add_column :users, :note, :string
  end
end
