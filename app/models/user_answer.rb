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
#

class UserAnswer < ActiveRecord::Base
  before_create :check_if_correct

  belongs_to :answer
  belongs_to :user_exam
  has_one :question, through: :answer


  private

  def check_if_correct
    self.correct = answer.correct
  end
end
