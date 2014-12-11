# == Schema Information
#
# Table name: user_exams
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  exam_id    :integer
#  created_at :datetime
#  updated_at :datetime
#  result     :decimal(, )      default(0.0)
#  closed     :boolean          default(FALSE)
#

require 'rails_helper'

RSpec.describe UserExam, :type => :model do
  describe 'validation' do
    it { is_expected.to validate_presence_of :user_id }

    it { is_expected.to validate_presence_of :exam_id }
  end

  describe '#update_result' do
    before do
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
        FactoryGirl.create :course
        FactoryGirl.create :lesson_category
        FactoryGirl.create :exam
        FactoryGirl.create :user
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
        UserAnswer.create!(user_exam_id: 1, answer_id: 10, question_id: 4)
        UserAnswer.create!(user_exam_id: 1, answer_id: 11, question_id: 4)
        UserAnswer.create!(user_exam_id: 1, answer_id: 12, question_id: 4)
        UserAnswer.create!(user_exam_id: 1, question_id: 5, text: 'czerwony')
      end

      it "has correct result" do
        @ue.update_result
        expect(@ue.result).to eq 5.0
        expect(CategoryResult.first.value).to eq 3.0
        expect(CategoryResult.second.value).to eq 2.0
      end
    end
  end
end
