# == Schema Information
#
# Table name: user_answers
#
#  id           :integer          not null, primary key
#  answer_id    :integer
#  user_exam_id :integer
#  correct      :boolean
#  created_at   :datetime
#  updated_at   :datetime
#  text         :string(255)
#  question_id  :integer
#

class UserAnswer < ActiveRecord::Base
  before_create :check_if_correct

  belongs_to :answer
  belongs_to :user_exam
  belongs_to :question

  has_one :question_category, through: :question

  validates :user_exam_id, presence: true
  validates :question_id, presence: true
  validates :answer_id, uniqueness: { allow_blank: true,
                                       scope: [:user_exam_id] }
  validate :open_user_exam


  private

  def check_if_correct
    unless question.open?
      self.correct = answer.try :correct
    else
      self.correct = !!question.answers.where('lower(name) = ?', text.downcase).first
    end
    true
  end

  def open_user_exam
    if user_exam.try :closed
      errors[:base] << "Sprawdzian zakończony"
    end
  end
end
