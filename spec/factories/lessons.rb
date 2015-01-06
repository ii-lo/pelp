# == Schema Information
#
# Table name: lessons
#
#  id                 :integer          not null, primary key
#  name               :string(255)
#  created_at         :datetime
#  updated_at         :datetime
#  lesson_category_id :integer
#  course_id          :integer
#  content            :text             default("")
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :lesson do
    name "MyString"
    lesson_category_id 1
  end
end
