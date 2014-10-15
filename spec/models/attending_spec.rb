# == Schema Information
#
# Table name: attendings
#
#  id           :integer          not null, primary key
#  course_id    :integer
#  user_id      :integer
#  created_at   :datetime
#  updated_at   :datetime
#  last_visited :datetime
#

require 'rails_helper'

RSpec.describe Attending, :type => :model do
  describe 'validation' do
    it { is_expected.to validate_presence_of :user_id }

    it { is_expected.to validate_presence_of :course_id }

    it { is_expected.to validate_uniqueness_of(:user_id).scoped_to [:course_id] }
  end

  describe "#set_last_visited" do
    it "have last_visited time after create" do
      FactoryGirl.create :attending
      expect(Attending.first.last_visited.strftime("%d-%m-%Y")).to(
        eq Time.now.strftime("%d-%m-%Y"))
    end
  end
end
