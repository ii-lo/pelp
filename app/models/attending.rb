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

  has_one :last_visit, as: :relation, dependent: :destroy

  validates :course_id, presence: true
  validates :user_id, presence: true,
                      uniqueness: { scope: [:course_id] }

  after_create :create_last_visit

  private

  def create_last_visit
    LastVisit.create(user_id: self.user_id, course_id: self.course_id,
                    relation_id: id, relation_type: 'Attending')
  end
end
