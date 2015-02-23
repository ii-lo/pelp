# == Schema Information
#
# Table name: invitations
#
#  id         :integer          not null, primary key
#  course_id  :integer
#  user_id    :integer
#  email      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  slug       :string
#  accepted   :boolean          default("f")
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :invitation do
    course_id 1
    user_id 1
    email "string@string.com"
  end
end
