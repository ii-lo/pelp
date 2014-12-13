# == Schema Information
#
# Table name: answers
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  correct     :boolean          default(FALSE)
#  question_id :integer
#  created_at  :datetime
#  updated_at  :datetime
#

class Answer < ActiveRecord::Base
  after_save :update_correct_answers_count
  before_destroy :update_correct_answers_count

  belongs_to :question

  has_many :user_answers
  has_one :question_category, through: :question

  validates :question_id, presence: true
  validates :name, presence: true,
            uniqueness: {scope: [:question_id]}

  scope :correct, -> { where(correct: true) }
  scope :wrong, -> { where(correct: false) }

  private

  def update_correct_answers_count
    if question.multiple?
      question.update_attribute(:correct_answers_count,
                                question.correct_answers.count)
    end
  end
end
