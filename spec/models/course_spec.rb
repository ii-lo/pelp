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
#  header      :string(255)
#  thumb       :string(255)
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

  describe "#to_s" do
    it "returns name" do
      course = FactoryGirl.build :course
      expect(course.to_s).to eq course.name
    end
  end
end
