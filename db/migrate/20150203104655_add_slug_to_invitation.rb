class AddSlugToInvitation < ActiveRecord::Migration
  def change
    add_column :invitations, :slug, :string, unique: true
  end
end
