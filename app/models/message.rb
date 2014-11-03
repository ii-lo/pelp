# == Schema Information
#
# Table name: messages
#
#  id          :integer          not null, primary key
#  sender_id   :integer
#  receiver_id :integer
#  title       :string(255)
#  body        :text(255)
#  created_at  :datetime
#  updated_at  :datetime
#  flagged     :boolean          default(FALSE)
#  in_trash    :boolean          default(FALSE)
#

class Message < ActiveRecord::Base
  belongs_to :sender, class_name: "User"
  belongs_to :receiver, class_name: "User"

  validates :sender_id, presence: true
  validates :receiver_id, presence: true
  validates :title, presence: true
end
