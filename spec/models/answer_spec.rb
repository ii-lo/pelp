# == Schema Information
#
# Table name: answers
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  correct     :boolean          default("f")
#  question_id :integer
#  created_at  :datetime
#  updated_at  :datetime
#

require 'rails_helper'

RSpec.describe Answer, :type => :model do
  describe 'validation' do
    it { is_expected.to validate_presence_of :name }

    it { is_expected.to validate_presence_of :question }

    describe '#only_one_correct_if_single' do
      before do
        FactoryGirl.create :course
        FactoryGirl.create :lesson_category
        FactoryGirl.create :exam
        FactoryGirl.create :question_category
        FactoryGirl.create :question
      end

      context "there are no correct answers" do
        before do
          FactoryGirl.create :answer
        end

        it "is valid" do
          answer = FactoryGirl.build :answer, name: "Nie",
            correct: true
          expect(answer).to be_valid
        end
      end

      context "there is a correct answer" do
        before do
          FactoryGirl.create :answer, correct: true
        end

        it "is invalid" do
          answer = FactoryGirl.build :answer, name: "Nie",
            correct: true
          expect(answer).to be_invalid
        end
      end

      context "updating" do
        before do
          FactoryGirl.create :answer, correct: true
        end

        it "is valid" do
          expect(Answer.first.update_attributes({ name: "Takowo" }))
            .to eq true
        end
      end
    end

  end
end
