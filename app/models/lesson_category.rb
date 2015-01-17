# == Schema Information
#
# Table name: lesson_categories
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  course_id  :integer
#  created_at :datetime
#  updated_at :datetime
#  flagged    :boolean          default("f")
#

class LessonCategory < ActiveRecord::Base
  belongs_to :course

  has_many :lessons
  has_many :exams
  has_many :material_categories
  has_many :published_exams, -> { where published: true }, class_name: "Exam"

  validates :course_id, presence: true
end
