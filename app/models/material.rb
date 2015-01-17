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

class Material < ActiveRecord::Base
  belongs_to :material_category

  validates :name, presence: true

  has_one :course, through: :material_category

  has_attached_file :file
  validates_attachment :file, presence: true, content_type:{
    content_type: /.+/
  }
end
