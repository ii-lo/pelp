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

require 'rails_helper'

RSpec.describe Invitation, :type => :model do
  describe 'validation' do
    it { is_expected.to validate_presence_of :course }

    it { is_expected.to validate_presence_of :user }

    it { is_expected.to validate_presence_of :email }

    describe '#already_send' do
      before do
        FactoryGirl.create :course
        FactoryGirl.create :user
        Attending.create(course_id: 1, user_id: 1, role: 2)
        Invitation.create(course_id: 1, user_id: 1, email: "k@k.com")
      end

      context 'already sent' do
        it 'is invalid' do
          inv = Invitation.new(course_id: 1, user_id: 1, email: "K@k.com")
          expect(inv).to be_invalid
        end
      end

      context 'new mail' do
        it 'is valid' do
          inv = Invitation.new(course_id: 1, user_id: 1, email: "K1@kj.com")
          expect(inv).to be_valid
        end
      end
    end

    describe '#already_member' do
      before do
        FactoryGirl.create :course
        FactoryGirl.create :user
        Attending.create(course_id: 1, user_id: 1, role: 2)
      end
      context 'already a member' do
        it 'is invalid' do
          inv = Invitation.new(course_id: 1, user_id: 1, email: User.first.email)
          expect(inv).not_to be_valid
        end
      end
    end
  end
end
