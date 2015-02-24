# == Schema Information
#
# Table name: question_categories
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#  exam_id    :integer
#

class QuestionCategory < ActiveRecord::Base
  belongs_to :exam

  has_many :questions, dependent: :destroy
  has_many :category_results, dependent: :destroy
  has_many :answers, through: :questions
  has_many :user_answers, through: :questions

  validates :exam, presence: true
  validates :name, presence: true,
    uniqueness: { scope: [:exam_id] },
    length: { maximum: 255 }
end
