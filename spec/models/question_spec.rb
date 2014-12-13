# == Schema Information
#
# Table name: questions
#
#  id                    :integer          not null, primary key
#  exam_id               :integer
#  name                  :string(255)
#  value                 :integer
#  created_at            :datetime
#  updated_at            :datetime
#  form                  :integer          default(0)
#  question_category_id  :integer
#  correct_answers_count :integer          default(0)
#

require 'rails_helper'

RSpec.describe Question, :type => :model do
  describe 'validation' do
    it { is_expected.to validate_presence_of :name }

    it { is_expected.to validate_presence_of :exam_id }

    it { is_expected.to validate_presence_of :value }

    it "is valid when valid" do
      expect(FactoryGirl.build(:question)).to be_valid
    end

    it "is invalid when value too big" do
      expect(FactoryGirl.build(:question, value: 201)).to be_invalid
    end
  end
end
