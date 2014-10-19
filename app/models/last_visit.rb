# == Schema Information
#
# Table name: last_visits
#
#  id            :integer          not null, primary key
#  user_id       :integer
#  course_id     :integer
#  date          :datetime
#  created_at    :datetime
#  updated_at    :datetime
#  relation_id   :integer
#  relation_type :string(255)
#

class LastVisit < ActiveRecord::Base
  belongs_to :user
  belongs_to :course
  belongs_to :relation

  validates :user_id, presence: true,
    uniqueness: { scope: [:course_id] }
  validates :course_id, presence: true

  before_create :set_date

  def update_date
    self.update_attribute(:date, Time.now.in_time_zone)
  end

  private
  def set_date
    self.date = Time.now
  end
end
