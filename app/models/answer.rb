# == Schema Information
#
# Table name: answers
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  correct     :boolean          default("f")
#  question_id :integer
#  created_at  :datetime
#  updated_at  :datetime
#

class Answer < ActiveRecord::Base
  after_save :update_correct_answers_count
  after_destroy :update_correct_answers_count

  belongs_to :question

  has_many :user_answers
  has_one :question_category, through: :question
  has_one :exam, through: :question

  validates :question, presence: true
  validates :name, presence: true,
            uniqueness: {scope: [:question_id]},
            length: { maximum: 255 }
  validate :only_one_correct_if_single

  scope :correct, -> { where(correct: true) }
  scope :wrong, -> { where(correct: false) }

  private

  def update_correct_answers_count
    if question.multiple?
      question.update_attribute(:correct_answers_count,
                                question.correct_answers.count)
    end
  end

  def only_one_correct_if_single
    return true unless correct
    return true unless question.try(:single?)
    ans = question.correct_answers.first
    if ans && ans != self
      errors[:base] << "Już istnieje prawidłowa odpowiedź"
    end
  end

end
