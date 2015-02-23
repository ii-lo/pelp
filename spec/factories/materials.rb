# == Schema Information
#
# Table name: materials
#
#  id                   :integer          not null, primary key
#  name                 :string
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  file_file_name       :string
#  file_content_type    :string
#  file_file_size       :integer
#  file_updated_at      :datetime
#  material_category_id :integer
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :material do
    material_category_id 1
    name "MyString"
    file { Rack::Test::UploadedFile.new File.join(Rails.root, "/spec/factories/paperclip", "pelp.png"), 'image/png' }
  end
end
