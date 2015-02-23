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

class MaterialCategory < ActiveRecord::Base
  belongs_to :lesson_category

  has_many :materials, dependent: :destroy
  has_one :course, through: :lesson_category

  validates :lesson_category_id, presence: true
  validates :name, presence: true
end
