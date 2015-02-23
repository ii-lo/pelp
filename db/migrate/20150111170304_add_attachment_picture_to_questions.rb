class AddAttachmentPictureToQuestions < ActiveRecord::Migration
  def self.up
    change_table :questions do |t|
      t.attachment :picture
    end
  end

  def self.down
    remove_attachment :questions, :picture
  end
end
