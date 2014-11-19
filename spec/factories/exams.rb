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
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :exam do
    name "MyString"
    course nil
  end
end
