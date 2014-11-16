# == Schema Information
#
# Table name: lesson_categories
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  course_id  :integer
#  created_at :datetime
#  updated_at :datetime
#  flagged    :boolean          default(FALSE)
#

class LessonCategory < ActiveRecord::Base
  belongs_to :course

  has_many :lessons

  validates :course_id, presence: true
end
