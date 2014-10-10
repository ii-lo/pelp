# == Schema Information
#
# Table name: ownerships
#
#  id         :integer          not null, primary key
#  course_id  :integer
#  user_id    :integer
#  created_at :datetime
#  updated_at :datetime
#

class Ownership < ActiveRecord::Base
  belongs_to :course
  belongs_to :user

  validates :user_id, presence: true
  validates :course_id, presence: true,
                        uniqueness: { scope: [:user_id] }
end
