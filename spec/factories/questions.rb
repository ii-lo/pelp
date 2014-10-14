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
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :question do
    exam_id 1
    name "MyString"
    value 1
  end
end