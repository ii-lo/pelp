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

  after_create { RemoveInvitationJob.set(wait: 1.week).perform_later(self) }

  belongs_to :course
  belongs_to :user

  validates :course_id, presence: true
  validates :user_id, presence: true
  validates :email, format: /@/,
                    presence: true
  validate :already_sent
  validate :already_member

  scope :accepted, -> { where accepted: true }

  def accept!
    update_attribute(:accepted, true)
  end

  private

  def already_sent
    if course && course.invitations.where('LOWER("invitations"."email") = ?', email.downcase).any?
      errors[:email] << "Już wysłano"
    end
  end

  def already_member
    if course && course.users.where('LOWER("users"."email") = ?', email.downcase).any?
      errors[:email] << "#{email} jest już uczestnikiem kursu"
    end
  end
end
