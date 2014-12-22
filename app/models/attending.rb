# == Schema Information
#
# Table name: attendings
#
#  id         :integer          not null, primary key
#  course_id  :integer
#  user_id    :integer
#  created_at :datetime
#  updated_at :datetime
#  last_visit :datetime
#

class Attending < ActiveRecord::Base
  belongs_to :course
  belongs_to :user

  validates :course_id, presence: true
  validates :user_id, presence: true,
            uniqueness: {scope: [:course_id]}

  before_create :set_last_visit

  def update_last_visit
    update_attribute(:last_visit, Time.now.in_time_zone)
  end

  private

  def set_last_visit
    self.last_visit = Time.now.in_time_zone
  end
end
