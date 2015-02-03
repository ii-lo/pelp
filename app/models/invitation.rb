# == Schema Information
#
# Table name: invitations
#
#  id         :integer          not null, primary key
#  course_id  :integer
#  user_id    :integer
#  email      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  slug       :string
#  accepted   :boolean          default("f")
#

class Invitation < ActiveRecord::Base
  include Sluggable

  belongs_to :course
  belongs_to :user

  validates :course_id, presence: true
  validates :user_id, presence: true
  validates :email, format: /@/,
                    presence: true

  def accept!
    update_attribute(:accepted, true)
  end
end
