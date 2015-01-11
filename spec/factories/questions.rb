# == Schema Information
#
# Table name: questions
#
#  id                    :integer          not null, primary key
#  exam_id               :integer
#  name                  :text(255)
#  value                 :integer
#  created_at            :datetime
#  updated_at            :datetime
#  form                  :integer          default(0)
#  question_category_id  :integer
#  correct_answers_count :integer          default(0)
#  picture_file_name     :string(255)
#  picture_content_type  :string(255)
#  picture_file_size     :integer
#  picture_updated_at    :datetime
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :question do
    exam_id 1
    name "MyString"
    value 1
    question_category_id 1
  end
end
