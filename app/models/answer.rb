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
  belongs_to :question

  validates :question_id, presence: true
  validates :name, presence: true

  scope :correct, -> { where(correct: true) }
  scope :wrong, -> { where(correct: false) }
end
