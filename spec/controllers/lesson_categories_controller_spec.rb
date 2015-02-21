require 'rails_helper'

RSpec.describe LessonCategoriesController, :type => :controller do
  before do
    @user = FactoryGirl.create :user
    sign_in :user, @user
    FactoryGirl.create :course
    Attending.create(user_id: 1, course_id: 1, role: 2)
  end
  describe "POST create" do
    context 'valid' do
      it 'creates lesson category' do
        expect do
          post :create, course_id: 1,
            lesson_category: { name: "t", flagged: '0' }
        end.to change(LessonCategory, :count).by(1)
        expect(response).to redirect_to edit_course_path(1)
      end
    end

    context 'invlid' do
      it 'does not create lesson category' do
        expect do
          post :create, course_id: 1,
            lesson_category: { name: "", flagged: '0' }
        end.not_to change(LessonCategory, :count)
        expect(response).to redirect_to edit_course_path(1)
      end
    end
  end

  context 'DELETE destroy' do
    before do
      FactoryGirl.create :lesson_category
    end

    it 'destroys LessonCategory' do
      expect do
        delete :destroy, id: 1, course_id: 1
      end.to change(LessonCategory, :count).by(-1)
      expect(response).to redirect_to edit_course_path(1)
    end
  end

  context 'PATCH update' do
    before do
      FactoryGirl.create :lesson_category
    end

    context 'valid' do
      it 'updates lesson category' do
        patch :update, id: 1, course_id: 1,
          lesson_category: { name: "Nazwa" }
        expect(LessonCategory.first.name).to eq "Nazwa"
      expect(response).to redirect_to edit_course_path(1)
      end
    end

    context 'invalid' do
      it 'does not update attributes' do
        patch :update, id: 1, course_id: 1,
          lesson_category: { name: "" }
        expect(LessonCategory.first.name).not_to eq ""
        expect(response).to redirect_to edit_course_path(1)
      end
    end
  end

end
