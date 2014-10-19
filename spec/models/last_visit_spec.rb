# == Schema Information
#
# Table name: last_visits
#
#  id            :integer          not null, primary key
#  user_id       :integer
#  course_id     :integer
#  date          :datetime
#  created_at    :datetime
#  updated_at    :datetime
#  relation_id   :integer
#  relation_type :string(255)
#

require 'rails_helper'

RSpec.describe LastVisit, :type => :model do
  describe 'validation' do
    it { is_expected.to validate_presence_of :user_id }

    it { is_expected.to validate_presence_of :course_id }

    it { is_expected.to validate_uniqueness_of(:user_id).scoped_to [:course_id] }
  end
end
