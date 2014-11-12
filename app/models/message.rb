# == Schema Information
#
# Table name: messages
#
#  id         :integer          not null, primary key
#  sender_id  :integer
#  title      :string(255)
#  body       :text(255)
#  created_at :datetime
#  updated_at :datetime
#  flagged    :boolean          default(FALSE)
#  in_trash   :boolean          default(FALSE)
#

class Message < ActiveRecord::Base
  belongs_to :sender, class_name: "User"

  has_many :sendings, dependent: :destroy
  has_many :receivers, through: :sendings, source: :user

  validates :sender_id, presence: true
  validates :title, presence: true
end
