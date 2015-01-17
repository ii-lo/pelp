# == Schema Information
#
# Table name: exams
#
#  id                 :integer          not null, primary key
#  name               :string(255)
#  course_id          :integer
#  created_at         :datetime
#  updated_at         :datetime
#  lesson_category_id :integer
#  duration           :integer
#  max_points         :integer          default("0")
#  published          :boolean          default("f")
#  one_run            :boolean          default("f")
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :exam do
    name "MyString"
    lesson_category_id 1
    duration 7200
    course_id 1
  end
end
