# == Schema Information
#
# Table name: exams
#
#  id                 :integer          not null, primary key
#  name               :string(255)
#  course_id          :integer
#  created_at         :datetime
#  updated_at         :datetime
#  lesson_category_id :integer
#

class Exam < ActiveRecord::Base
  before_save :course_id

  belongs_to :course
  belongs_to :lesson_category

  has_many :questions

  validates :name, presence: true
  validates :lesson_category_id, presence: true
  validates :course_id, presence: true,
            uniqueness: {scope: [:name]}

  private

  def course_id
    self.course_id = lesson_category.try(:exam_id)
  end
end
