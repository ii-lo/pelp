class AddPasswordToCourse < ActiveRecord::Migration
  def change
    add_column :courses, :password, :string, default: ''
  end
end
