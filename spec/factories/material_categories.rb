# == Schema Information
#
# Table name: material_categories
#
#  id                 :integer          not null, primary key
#  lesson_category_id :integer
#  name               :string
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :material_category do
    lesson_category_id 1
    name "MyString"
  end
end
