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
  enum form: %w(single multiple open)

  before_save :update_exam_max
  before_destroy :update_exam_max


  belongs_to :exam

  has_many :answers
  has_many :correct_answers, -> { correct }, class_name: 'Answer'
  has_many :wrong_answers, -> { wrong }, class_name: 'Answer'
  has_many :user_answers, through: :answers

  validates :exam_id, presence: true
  validates :name, presence: true
  validates :value, presence: true,
            inclusion: 0..200

  private

  def update_exam_max
    exam.update_max_points
  end
end
