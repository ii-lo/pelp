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

  validates :user_exam_id, presence: true,
            uniqueness: { scope: [:answer_id] }
  validates :question_id, presence: true


  private

  def check_if_correct
    unless question.open?
      self.correct = answer.correct
    else
      self.correct = !!question.answers.where('lower(name) = ?', text.downcase).first
    end
    true
  end
end
