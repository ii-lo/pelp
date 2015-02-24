# == Schema Information
#
# Table name: questions
#
#  id                    :integer          not null, primary key
#  exam_id               :integer
#  name                  :text(255)
#  value                 :integer
#  created_at            :datetime
#  updated_at            :datetime
#  form                  :integer          default("0")
#  question_category_id  :integer
#  correct_answers_count :integer          default("0")
#  picture_file_name     :string(255)
#  picture_content_type  :string(255)
#  picture_file_size     :integer
#  picture_updated_at    :datetime
#

require 'rails_helper'

RSpec.describe Question, :type => :model do
  describe 'validation' do
    it { is_expected.to validate_presence_of :name }

    it { is_expected.to validate_presence_of :exam }

    it { is_expected.to validate_presence_of :value }

    it "is valid when valid" do
      e = Exam.new
      q = FactoryGirl.build :question
      allow(q).to receive(:exam) { e }
      allow(q).to receive(:question_category) { FactoryGirl.build(:question_category) }
      expect(q).to be_valid
    end

    it "is invalid when value too big" do
      e = Exam.new
      q = FactoryGirl.build :question, value: 201
      allow(q).to receive(:exam) { e }
      allow(q).to receive(:question_category) { FactoryGirl.build(:question_category) }
      expect(q).to be_invalid
    end
  end
end
