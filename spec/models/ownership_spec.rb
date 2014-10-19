# == Schema Information
#
# Table name: ownerships
#
#  id         :integer          not null, primary key
#  course_id  :integer
#  user_id    :integer
#  created_at :datetime
#  updated_at :datetime
#

require 'rails_helper'

RSpec.describe Ownership, :type => :model do
  describe 'validation' do
    it { is_expected.to validate_presence_of :course_id }

    it { is_expected.to validate_presence_of :user_id }

    it { is_expected.to validate_uniqueness_of(:course_id).scoped_to [:user_id] }
  end

  describe 'after_create' do
    it "creates last visit" do
      expect do
        FactoryGirl.create :ownership
      end.to change{LastVisit.count}.by 1
    end
  end
end
