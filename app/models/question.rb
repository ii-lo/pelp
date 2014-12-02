# == Schema Information
#
# Table name: questions
#
#  id         :integer          not null, primary key
#  exam_id    :integer
#  name       :string(255)
#  value      :integer
#  created_at :datetime
#  updated_at :datetime
#  form       :integer          default(0)
#

class Question < ActiveRecord::Base

  belongs_to :exam

  has_many :answers
  has_many :correct_answers, -> { correct }, class_name: 'Answer'
  has_many :wrong_answers, -> { wrong }, class_name: 'Answer'

  validates :exam_id, presence: true
  validates :name, presence: true
  validates :value, presence: true,
            inclusion: 0..200
end
