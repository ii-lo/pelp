# == Schema Information
#
# Table name: attendings
#
#  id         :integer          not null, primary key
#  course_id  :integer
#  user_id    :integer
#  created_at :datetime
#  updated_at :datetime
#  last_visit :datetime
#  role       :integer          default(0)
#

require 'rails_helper'

RSpec.describe Attending, :type => :model do
  describe 'validation' do
    it { is_expected.to validate_presence_of :user_id }

    it { is_expected.to validate_presence_of :course_id }

    it { is_expected.to validate_uniqueness_of(:user_id).scoped_to [:course_id] }
  end

  describe 'after_create' do
    it "sets last visit" do
      att = FactoryGirl.create :attending
      expect(Time.now.all_day).to cover att.last_visit
    end
  end

end
