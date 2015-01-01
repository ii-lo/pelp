# == Schema Information
#
# Table name: user_answers
#
#  id           :integer          not null, primary key
#  answer_id    :integer
#  user_exam_id :integer
#  correct      :boolean
#  created_at   :datetime
#  updated_at   :datetime
#  text         :string(255)
#  question_id  :integer
#

require 'rails_helper'

RSpec.describe UserAnswer, :type => :model do
  before do
    FactoryGirl.create :user_exam
  end
  describe 'validation' do
    subject { UserAnswer.new(user_exam_id: 1) }

    it { is_expected.to validate_presence_of :user_exam_id }

    it { is_expected.to validate_presence_of :question_id }

    describe '#open_user_exam' do
      context "exam is open" do
        it "is valid" do
          expect(FactoryGirl.build :user_answer).to be_valid
        end
      end

      context "exam is closed" do
        before do
          UserExam.first.update_attribute(:closed, true)
        end

        it "is invalid" do
          expect(FactoryGirl.build :user_answer).to be_invalid
        end
      end
    end
  end
end
