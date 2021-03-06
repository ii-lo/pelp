# == Schema Information
#
# Table name: user_exams
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  exam_id    :integer
#  created_at :datetime
#  updated_at :datetime
#  result     :decimal(, )      default("0.0")
#  closed     :boolean          default("f")
#

require 'rails_helper'

RSpec.describe UserExam, :type => :model do
  describe 'validation' do
    it { is_expected.to validate_presence_of :user }

    it { is_expected.to validate_presence_of :exam }
  end

  describe '#update_result' do
    before do
      FactoryGirl.create :course
      FactoryGirl.create :lesson_category
      FactoryGirl.create :exam
      FactoryGirl.create :user
      QuestionCategory.create(name: 'a', exam_id: 1)
      QuestionCategory.create(name: 'b', exam_id: 1)
    end

    context "no user_answers" do
      before do
        @ue = FactoryGirl.create :user_exam
      end
      it "has result 0" do
        expect(@ue.result).to eq 0
      end
    end

    context "many user_answers" do
      before do
        @ue = FactoryGirl.create :user_exam
        FactoryGirl.create(:question,
                          name: "Czy ziemia jest płaska?",
                          value: 2,
                          question_category_id: 2)
        Answer.create(name: "Tak", correct: false, question_id: 1)
        Answer.create(name: "Nie", correct: true, question_id: 1)
        FactoryGirl.create(:question,
                          name: "Czy Pepsi jest lepsze, niż Coca-Cola?",
                          value: 2)
        Answer.create(name: "Tak", correct: true, question_id: 2)
        Answer.create(name: "Nie", correct: false, question_id: 2)
        FactoryGirl.create(:question,
                          name: "Jakie programy domyślnie ma Łubuntu?",
                          value: 2, form: 1)
        Answer.create(name: "Firefox", correct: true, question_id: 3)
        Answer.create(name: "Google Chrome", correct: false, question_id: 3)
        Answer.create(name: "LibreOffice Writer", correct: true, question_id: 3)
        Answer.create(name: "Microsoft Office Word", correct: false, question_id: 3)
        FactoryGirl.create(:question,
                          name: "Który z wymienionych był królem Polski?",
                          value: 2, form: 1)
        Answer.create(name: "Bolesław Chrobry", correct: true, question_id: 4)
        Answer.create(name: "Michael Schumacher", correct: false, question_id: 4)
        Answer.create(name: "Kazimierz Wielki", correct: true, question_id: 4)
        Answer.create(name: "Donald Tusk", correct: false, question_id: 4)
        FactoryGirl.create(:question,
                          name: "Jakiego koloru jest krew ludzka?",
                          form: 2,
                          value: 2,
                          question_category_id: 2)
        Answer.create(name: "Czerwonego", question_id: 5)
        Answer.create(name: "Czerwony", question_id: 5)
        UserAnswer.create!(user_exam_id: 1, question_id: 1, answer_id: 1)
        UserAnswer.create!(user_exam_id: 1, question_id: 2, answer_id: 3)
        UserAnswer.create!(user_exam_id: 1, answer_id: 5, question_id: 3)
        UserAnswer.create!(user_exam_id: 1, answer_id: 6, question_id: 3)
        UserAnswer.create!(user_exam_id: 1, answer_id: 7, question_id: 3)
        UserAnswer.create!(user_exam_id: 1, answer_id: 9, question_id: 4)
        UserAnswer.create!(user_exam_id: 1, answer_id: nil, question_id: 4)
        UserAnswer.create!(user_exam_id: 1, answer_id: 11, question_id: 4)
        UserAnswer.create!(user_exam_id: 1, answer_id: 12, question_id: 4)
        UserAnswer.create!(user_exam_id: 1, question_id: 5, text: 'czerwony')
      end

      it "has correct result" do
        @ue.update_result
        expect(@ue.result).to eq 6.0
        expect(CategoryResult.first.value).to eq 4.0
        expect(CategoryResult.second.value).to eq 2.0
      end
    end
  end

  describe '#mark_multiple' do
    before do
      @u_e = UserExam.new
    end

    context "half of correct answers" do
      before do
        @question = double Question, correct_answers_count: 2,
          value: 2, form: 1
        @u_a = [
          double(UserAnswer, correct: true, answer_id: 1),
          double(UserAnswer, answer_id: nil),
          double(UserAnswer, answer_id: nil),
          double(UserAnswer, answer_id: nil)
        ]
      end

      it "returns half of qestion value" do
        expect(
          @u_e.send(:mark_multiple, @question, @u_a)
        ).to eq 1.0
      end
    end

    context "one incorrect answer" do
      before do
        @question = double Question, correct_answers_count: 3,
          value: 2, form: 1
        @u_a = [
          double(UserAnswer, correct: true, answer_id: 1),
          double(UserAnswer, answer_id: 2, correct: false),
          double(UserAnswer, answer_id: 3, correct: true),
          double(UserAnswer, answer_id: nil)
        ]
      end

      it "part of total value" do
        expect(
          @u_e.send(:mark_multiple, @question, @u_a)
        ).to eq @question.value * 1.0/3
      end
    end

    context "as many correct as incorrect answers" do
      before do
        @question = double Question, correct_answers_count: 2,
          value: 2, form: 1
        @u_a = [
          double(UserAnswer, correct: true, answer_id: 1),
          double(UserAnswer, answer_id: 2, correct: false),
          double(UserAnswer, answer_id: nil),
          double(UserAnswer, answer_id: nil)
        ]
      end

      it "returns 0" do
        expect(
          @u_e.send(:mark_multiple, @question, @u_a)
        ).to eq 0
      end
    end

    context "more incorrect than correct answers" do
      before do
        @question = double Question, correct_answers_count: 2,
          value: 2, form: 1
        @u_a = [
          double(UserAnswer, correct: true, answer_id: 1),
          double(UserAnswer, answer_id: 2, correct: false),
          double(UserAnswer, answer_id: 3, correct: false),
          double(UserAnswer, answer_id: nil)
        ]
      end

      it "returns 0" do
        expect(
          @u_e.send(:mark_multiple, @question, @u_a)
        ).to eq 0
      end
    end
  end

  describe '#close!' do
    before do
      FactoryGirl.create :course
      FactoryGirl.create :lesson_category
      FactoryGirl.create :exam
      FactoryGirl.create :user
      FactoryGirl.create :user_exam
    end
    context "closed" do
      before do
        UserExam.first.update_attribute(:closed, true)
      end

      it "returns :already_closed" do
        expect(UserExam.first.close!).to eq :already_closed
      end
    end

    context "open" do
      it "updates self" do
        expect(UserExam.first.close!).to eq 0 # result returned
        expect(UserExam.first.open?).to eq false
      end
    end
  end
end
