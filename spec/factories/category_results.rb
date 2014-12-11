# == Schema Information
#
# Table name: category_results
#
#  id                   :integer          not null, primary key
#  user_exam_id         :integer
#  question_category_id :integer
#  value                :decimal(, )      default(0.0)
#  created_at           :datetime
#  updated_at           :datetime
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :category_result do
    user_exam_id 1
    question_category_id 1
    value "9.99"
  end
end
