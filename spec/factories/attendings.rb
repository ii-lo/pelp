# == Schema Information
#
# Table name: attendings
#
#  id         :integer          not null, primary key
#  course_id  :integer
#  user_id    :integer
#  created_at :datetime
#  updated_at :datetime
#  last_visit :datetime
#  role_id    :integer
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :attending do
    course_id 1
    user_id 1
    role_id 1
  end
end
