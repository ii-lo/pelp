# == Schema Information
#
# Table name: attendings
#
#  id         :integer          not null, primary key
#  course_id  :integer
#  user_id    :integer
#  created_at :datetime
#  updated_at :datetime
#

class Attending < ActiveRecord::Base
  belongs_to :course
  belongs_to :user

  validates :course_id, presence: true
  validates :user_id, presence: true,
                      uniqueness: { scope: [:course_id] }
end
