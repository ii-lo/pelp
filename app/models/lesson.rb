# == Schema Information
#
# Table name: lessons
#
#  id                 :integer          not null, primary key
#  name               :string(255)
#  created_at         :datetime
#  updated_at         :datetime
#  lesson_category_id :integer
#

class Lesson < ActiveRecord::Base
  belongs_to :course
  belongs_to :lesson_category

  validates :name, presence: true
  validates :lesson_category_id, presence: true
end
