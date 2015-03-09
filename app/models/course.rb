# == Schema Information
#
# Table name: courses
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#  description :string(255)
#  private     :boolean          default("f")
#  header      :string(255)
#  thumb       :string(255)
#  password    :string           default("")
#

class Course < ActiveRecord::Base
  has_many :attendings, dependent: :destroy
  has_many :users, through: :attendings
  has_many :lesson_categories, dependent: :destroy
  #has_many :lessons, through: :lesson_categories, dependent: :destroy
  has_many :lessons, dependent: :destroy
  has_many :exams, dependent: :destroy
  has_many :material_categories, through: :lesson_categories
  has_many :materials, through: :material_categories
  has_many :admins, -> { where attendings: { role: [1, 2] } }, through: :attendings, source: :user
  has_many :admins_only, -> { where attendings: { role: 1 } }, through: :attendings, source: :user
  has_many :ordinary_users, -> { where attendings: { role: 0 } }, through: :attendings, source: :user
  has_many :owners, -> { where attendings: { role: 2 } }, through: :attendings, source: :user
  has_many :invitations, dependent: :destroy

  validates :name, presence: true
  validates :description, length: {
    maximum: 240,
    allow_blank: true
  }
  validates :password, length: { maximum: 400 }

  scope :open, -> { where(private: false) }

  alias_method :students, :users

  def to_s
    name
  end
end
