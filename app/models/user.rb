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
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  created_at             :datetime
#  updated_at             :datetime
#  name                   :string(255)
#

class User < ActiveRecord::Base
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :name, presence: true,
                   length: { maximum: 240 }

  has_many :attendings, dependent: :destroy
  has_many :courses, through: :attendings
  has_many :owned_courses, through: :attendings, source: :course

  def last_visited_courses(number = nil)
    return last_visited_courses.limit(number) if number
    courses.joins(:attendings).
      order('"attendings"."last_visit" DESC').uniq
  end
end
