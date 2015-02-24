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
  describe 'validation' do
    subject { UserAnswer.new(user_exam_id: 1) }

    it { is_expected.to validate_presence_of :user_exam }

    it { is_expected.to validate_presence_of :question }

    describe '#open_user_exam' do
      before do
        FactoryGirl.create :course
        FactoryGirl.create :lesson_category
        FactoryGirl.create :exam
        FactoryGirl.create :user
        FactoryGirl.create :user_exam
      end

      before do
        @u_a = FactoryGirl.build :user_answer
        allow(@u_a).to receive(:question) { FactoryGirl.build :question }
      end

      context "exam is open" do
        it "is valid" do
          expect(@u_a).to be_valid
        end
      end

      context "exam is closed" do
        before do
          UserExam.first.update_attribute(:closed, true)
        end

        it "is invalid" do
          expect(@u_a).to be_invalid
        end
      end
    end
  end

  describe '#check_if_correct' do
    context 'open' do
      before do
        FactoryGirl.create :course
        FactoryGirl.create :lesson_category
        FactoryGirl.create :exam
        FactoryGirl.create :question_category
        FactoryGirl.create :question, form: 2
        FactoryGirl.create :user
        FactoryGirl.create :user_exam
      end
      context 'answer exists' do
        before do
          Answer.create name: "TaK", question_id: 1
        end

        it 'is correct' do
          u_a = UserAnswer.create!(user_exam_id: 1, text: "tAK", question_id: 1)
          expect(u_a.correct).to eq true
        end
      end

      context 'answer does not exist' do
        before do
          Answer.create name: "nie", question_id: 1
        end

        it 'is incorrect' do
          u_a = UserAnswer.create!(user_exam_id: 1, text: "tAK", question_id: 1)
          expect(u_a.correct).to eq false
        end
      end
    end

    context 'multiple or single' do
      before do
        FactoryGirl.create :course
        FactoryGirl.create :lesson_category
        FactoryGirl.create :exam
        FactoryGirl.create :question_category
        FactoryGirl.create :question, form: 0
        Answer.create name: "nie", question_id: 1, correct: true
        Answer.create name: "tak", question_id: 1, correct: false
        FactoryGirl.create :user
        FactoryGirl.create :user_exam
      end

      context 'answer is correct' do
        it 'is correct' do
          u_a = UserAnswer.create!(user_exam_id: 1, answer_id: 1, question_id: 1)
          expect(u_a.correct).to eq true
        end
      end

      context 'answer is incorrect' do
        it 'is incorrect' do
          u_a = UserAnswer.create!(user_exam_id: 1, answer_id: 2, question_id: 1)
          expect(u_a.correct).to eq false
        end
      end
    end
  end
end
