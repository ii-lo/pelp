require 'rails_helper'

RSpec.describe AnswersController, :type => :controller do
  before do
    @user = FactoryGirl.create :user
    sign_in @user
    FactoryGirl.create :course
    FactoryGirl.create :lesson_category
    QuestionCategory.create(name: 'a', exam_id: 1)
    Attending.create(user_id: 1, course_id: 1, role_id: 0)
    FactoryGirl.create :exam
    FactoryGirl.create :question_category
    FactoryGirl.create :question
  end

  describe "POST create" do
    context "valid answer" do
      it "creates answer" do
        expect do
          post :create, question_id: 1, answer: { name: "Tak", correct: '0' }
        end.to change(Answer, :count).by(1)
      end
    end
    context "invalid answer" do
      it "does not create answer" do
        expect do
          post :create, question_id: 1, answer: { name: "" }
        end.not_to change(Answer, :count)
      end
    end
  end

  describe "DELETE destroy" do
    before do
      FactoryGirl.create :answer
    end

    it "destroys answer" do
      expect do
        delete :destroy, question_id: 1, id: 1
      end.to change(Answer, :count).by(-1)
    end
  end

end
