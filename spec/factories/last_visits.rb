# == Schema Information
#
# Table name: last_visits
#
#  id            :integer          not null, primary key
#  user_id       :integer
#  course_id     :integer
#  date          :datetime
#  created_at    :datetime
#  updated_at    :datetime
#  relation_id   :integer
#  relation_type :string(255)
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :last_visit do
    user_id 1
    course_id 1
    date "2014-10-19 20:14:27"
  end
end
