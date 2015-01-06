# == Schema Information
#
# Table name: lessons
#
#  id                 :integer          not null, primary key
#  name               :string(255)
#  created_at         :datetime
#  updated_at         :datetime
#  lesson_category_id :integer
#  course_id          :integer
#  content            :text             default("")
#

class Lesson < ActiveRecord::Base
  before_validation :set_course_id

  belongs_to :course
  belongs_to :lesson_category

  validates :name, presence: true,
    length: { maximum: 250 }
  validates :lesson_category_id, presence: true

  private

  def set_course_id
    self.course_id = lesson_category.try(:course_id)
  end
end
