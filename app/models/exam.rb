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
#  max_points         :integer          default(0)
#  published          :boolean          default(FALSE)
#

class Exam < ActiveRecord::Base
  before_validation :set_course_id

  belongs_to :course
  belongs_to :lesson_category

  has_many :questions, dependent: :destroy
  has_many :user_exams, dependent: :destroy
  has_many :question_categories, dependent: :destroy

  validates :name, presence: true, length: { maximum: 250 }
  validates :lesson_category_id, presence: true,
            uniqueness: {scope: [:name]}
  validates :duration, presence: true
  validates :course_id, presence: true

  scope :published, -> { where(published: true) }

  def update_max_points
    update_attribute(:max_points, questions.sum(:value))
  end

  private

  def set_course_id
    self.course_id = lesson_category.try(:course_id)
  end
end
