# == Schema Information
#
# Table name: category_results
#
#  id                   :integer          not null, primary key
#  user_exam_id         :integer
#  question_category_id :integer
#  value                :decimal(, )      default("0.0")
#  created_at           :datetime
#  updated_at           :datetime
#

class CategoryResult < ActiveRecord::Base
  belongs_to :user_exam
  belongs_to :question_category

  validates :user_exam, presence: true
  validates :question_category, presence: true
            #uniqueness: { scope: [:user_exam_id] }
end
