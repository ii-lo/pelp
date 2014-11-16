# == Schema Information
#
# Table name: lesson_categories
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  course_id  :integer
#  created_at :datetime
#  updated_at :datetime
#  flagged    :boolean          default(FALSE)
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :lesson_category do
    name "MyString"
    course nil
  end
end
