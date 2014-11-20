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
#  duration           :integer
#

class Exam < ActiveRecord::Base
  before_validation :set_course_id

  belongs_to :course
  belongs_to :lesson_category

  has_many :questions
  has_many :user_exams, dependent: :destroy

  validates :name, presence: true
  validates :lesson_category_id, presence: true,
            uniqueness: {scope: [:name]}
  validates :duration, presence: true

  private

  def set_course_id
    self.course_id = lesson_category.try(:course_id)
  end
end
