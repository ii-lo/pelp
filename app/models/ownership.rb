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
  has_one :last_visit, as: :relation, dependent: :destroy

  validates :user_id, presence: true
  validates :course_id, presence: true,
                        uniqueness: { scope: [:user_id] }

  after_create :create_last_visit

  private

  def create_last_visit
    LastVisit.create(user_id: self.user_id, course_id: self.course_id,
                    relation_id: id, relation_type: 'Ownership')
  end
end
