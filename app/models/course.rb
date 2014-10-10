# == Schema Information
#
# Table name: courses
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Course < ActiveRecord::Base
  validates :name, presence: true
  has_many :ownerships, dependent: :destroy
  has_many :owners, through: :ownerships, source: :user
  has_many :attendings, dependent: :destroy
  has_many :users, through: :attendings

  alias_method :students, :users
end
