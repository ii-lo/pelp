# == Schema Information
#
# Table name: sendings
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  message_id :integer
#  created_at :datetime
#  updated_at :datetime
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :sending do
    user nil
    message nil
  end
end
