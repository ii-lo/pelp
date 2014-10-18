# == Schema Information
#
# Table name: courses
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#  description :string(255)
#  private     :boolean          default(FALSE)
#

require 'rails_helper'

RSpec.describe Course, :type => :model do
  describe 'validation' do
    it { is_expected.to validate_presence_of :name }

    it "does not have too long description" do
      c = FactoryGirl.build :course
      expect(c).to be_valid
      c.description = 'a' * 241
      expect(c).to be_invalid
    end
  end
end
