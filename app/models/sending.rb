# == Schema Information
#
# Table name: sendings
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  message_id :integer
#  created_at :datetime
#  updated_at :datetime
#

class Sending < ActiveRecord::Base
  belongs_to :user
  belongs_to :message

  validates :user_id, presence: true
  validates :message_id, presence: true
end
