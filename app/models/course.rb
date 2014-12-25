# == Schema Information
#
# Table name: courses
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#  description :string(255)
#  private     :boolean          default(FALSE)
#  header      :string(255)
#  thumb       :string(255)
#

class Course < ActiveRecord::Base
  has_many :attendings, dependent: :destroy
  has_many :users, through: :attendings
  has_many :users, through: :attendings
  has_many :lesson_categories, dependent: :destroy
  has_many :lessons, through: :lesson_categories, dependent: :destroy
  has_many :exams, through: :lesson_categories, dependent: :destroy

  validates :name, presence: true
  validates :description, length: {
                            maximum: 240,
                            allow_blank: true
                        }

  scope :open, -> { where(private: false) }

  alias_method :students, :users
end
