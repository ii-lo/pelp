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
#

class Exam < ActiveRecord::Base
  belongs_to :course

  validates :name, presence: true
  validates :course_id, presence: true,
            uniqueness: {scope: [:name]}
end
