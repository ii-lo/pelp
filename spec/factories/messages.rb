# == Schema Information
#
# Table name: messages
#
#  id          :integer          not null, primary key
#  sender_id   :integer
#  receiver_id :integer
#  title       :string(255)
#  body        :text(255)
#  created_at  :datetime
#  updated_at  :datetime
#  flagged     :boolean          default(FALSE)
#  in_trash    :boolean          default(FALSE)
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :message do
    sender nil
    receiver nil
    topic "MyString"
    body "MyString"
  end
end
