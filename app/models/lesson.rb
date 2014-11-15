# == Schema Information
#
# Table name: lessons
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  course_id  :integer
#  created_at :datetime
#  updated_at :datetime
#

class Lesson < ActiveRecord::Base
  belongs_to :course

  validates :name, presence: true
  validates :course_id, presence: true
end
