# == Schema Information
#
# Table name: pictures
#
#  id                :integer          not null, primary key
#  slug              :string
#  description       :string           default("")
#  lesson_id         :integer
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  file_file_name    :string
#  file_content_type :string
#  file_file_size    :integer
#  file_updated_at   :datetime
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :picture do
    description ""
    lesson_id 1
    file { Rack::Test::UploadedFile.new File.join(Rails.root, "/spec/factories/paperclip", "pelp.png"), 'image/png' }
  end
end
