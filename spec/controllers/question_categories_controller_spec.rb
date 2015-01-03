require 'rails_helper'

RSpec.describe QuestionCategoriesController, :type => :controller do
  before do
    @user = FactoryGirl.create :user
    sign_in @user
    FactoryGirl.create :course
    FactoryGirl.create :lesson_category
    QuestionCategory.create(name: 'a', exam_id: 1)
    FactoryGirl.create :attending, role: 1
    FactoryGirl.create :exam
  end
  describe "POST create" do
    context "valid question category" do
      it "creates question category" do
        expect do
          post :create, exam_id: 1, question_category: { name: "Nazwa" }
        end.to change(QuestionCategory, :count).by(1)
        expect(response).to redirect_to edit_course_exam_path(1, 1)
      end
    end

    context "invalid question category" do
      it "does not create question category" do
        expect do
          post :create, exam_id: 1, question_category: { name: "" }
        end.not_to change(QuestionCategory, :count)
        expect(response).to redirect_to edit_course_exam_path(1, 1)
      end
    end
  end

  describe 'DELETE destroy' do
    before do
      FactoryGirl.create :question_category
    end
    it "destroys question category" do
      expect do
        delete :destroy, exam_id: 1, id: 1
      end.to change(QuestionCategory, :count).by(-1)
      expect(response).to redirect_to edit_course_exam_path(1, 1)
    end
  end

  describe "PATCH update" do
    before do
      FactoryGirl.create :question_category
    end

    context "valid params" do
      it "updates question category" do
        xhr :put, :update, exam_id: 1, id: 1,
          question_category: { name: "Takowe" }, format: :json
        expect(QuestionCategory.first.name).to eq "Takowe"
        expect(JSON.parse(response.body).deep_symbolize_keys)
          .to(eq({ :question_category => { name: "Takowe", id: 1 } }))
      end
    end

    context "invalid params" do
      it "renders json with error" do
        xhr :put, :update, exam_id: 1, id: 1,
          question_category: { name: "a" * 444 }, format: :json
        expect(response).to have_http_status 422
        expect(JSON.parse response.body).not_to be_nil
        expect(JSON.parse(response.body)['errors'].first).to(
          include 'długie'
        )
      end
    end
  end

end
