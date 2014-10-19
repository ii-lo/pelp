# == Schema Information
#
# Table name: attendings
#
#  id         :integer          not null, primary key
#  course_id  :integer
#  user_id    :integer
#  created_at :datetime
#  updated_at :datetime
#

require 'rails_helper'

RSpec.describe Attending, :type => :model do
  describe 'validation' do
    it { is_expected.to validate_presence_of :user_id }

    it { is_expected.to validate_presence_of :course_id }

    it { is_expected.to validate_uniqueness_of(:user_id).scoped_to [:course_id] }
  end

  describe 'after_create' do
    it "creates last visit" do
      expect do
        FactoryGirl.create :attending
      end.to change{LastVisit.count}.by 1
    end
  end

end
