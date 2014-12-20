require 'rails_helper'

RSpec.describe QuestionCategoriesController, :type => :controller do
  before do
    @user = FactoryGirl.create :user
    sign_in @user
    FactoryGirl.create :course
    FactoryGirl.create :lesson_category
    QuestionCategory.create(name: 'a', exam_id: 1)
    Attending.create(user_id: 1, course_id: 1, role_id: 0)
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

end
