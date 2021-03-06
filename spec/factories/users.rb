# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default("0"), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  created_at             :datetime
#  updated_at             :datetime
#  name                   :string(255)
#  location               :string
#  company                :string
#  contact_mail           :string
#  home_url               :string
#  note                   :string
#

FactoryGirl.define do
  factory :user do
    email 'example@ss.com'
    name "Robert Bias"
    password "haslo123"
    password_confirmation "haslo123"
  end
end
