require 'rails_helper'

RSpec.describe QuestionsController, :type => :controller do
  before do
    @user = FactoryGirl.create :user
    sign_in @user
    FactoryGirl.create :course
    FactoryGirl.create :lesson_category
    QuestionCategory.create(name: 'a', exam_id: 1)
    FactoryGirl.create :attending, role: 1
    FactoryGirl.create :exam
    FactoryGirl.create :question_category
  end

  describe "POST create" do
    context "valid question" do
      it "creates question" do
        expect do
          post :create, exam_id: 1, question_category_id: 1,
            question: { name: "nn", value: 1, form: :single }
        end.to change(Question, :count).by(1)
        expect(response).to redirect_to edit_course_exam_path(1, 1)
      end
    end

    context "invalid question" do
      it "does not create question" do
        expect do
          post :create, exam_id: 1, question_category_id: 1,
            question: { name: "", value: 1, form: :single }
        end.not_to change(Question, :count)
        expect(response).to redirect_to edit_course_exam_path(1, 1)
      end
    end
  end

  describe "PATCH update" do
    before do
      FactoryGirl.create :question
    end
    context "valid params" do
      it "updates answer" do
        xhr :patch, :update, exam_id: 1, question_category_id: 1, id: 1,
          question: { name: "Takowe", value: 2 }, format: :json
        expect(Question.first.name).to eq "Takowe"
        expect(JSON.parse(response.body).deep_symbolize_keys)
          .to(eq({ :question => { name: "Takowe", id: 1, value: 2 } }))
      end
    end

    context "invalid params" do
      it "renders json with error" do
        xhr :patch, :update, exam_id: 1, question_category_id: 1, id: 1,
          question: { value: 444 }, format: :json
        expect(response).to have_http_status 422
        expect(JSON.parse response.body).not_to be_nil
        expect(JSON.parse(response.body)['errors'].first).to(
          include 'znajduje'
        )
      end
    end
  end

  describe 'DELETE destroy' do
    before do
      FactoryGirl.create :question
    end
    it "destroys question" do
      expect do
        delete :destroy, question_category_id: 1, exam_id: 1, id: 1
      end.to change(Question, :count).by(-1)
    end
  end

end
