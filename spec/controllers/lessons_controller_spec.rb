require 'rails_helper'

RSpec.describe LessonsController, :type => :controller do
  before do
    @user = FactoryGirl.create :user
    sign_in @user
    FactoryGirl.create :course
    FactoryGirl.create :attending, role: 2
    FactoryGirl.create :lesson_category
  end

  describe "GET show" do
    before do
      FactoryGirl.create :lesson
    end

    it "renders show page" do
      get :show, course_id: 1, id: 1
      expect(response).to render_template :show
      expect(assigns(:lesson)).to eq Lesson.first
    end
  end

  describe "GET new" do
    it "renders new template" do
      get :new, course_id: 1
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST create" do
    context "valid params" do
      it "creates new lesson" do
        expect do
          post :create, course_id: 1,
            lesson: { name: "t", lesson_category_id: 1, content: "a" }
        end.to change(Lesson, :count).by(1)
        expect(response).to redirect_to course_lesson_path 1, 1
      end
    end

    context "invalid params" do
      it "does not create new lesson" do
        expect do
          post :create, course_id: 1,
            lesson: { lesson_category_id: 1, content: "a" }
        end.not_to change(Lesson, :count)
        expect(response).to render_template :new
      end
    end
  end

  describe "GET edit" do
    before do
      FactoryGirl.create :lesson
    end

    it "renders edit template" do
      get :edit, course_id: 1, id: 1
      expect(response).to have_http_status(:success)
    end
  end

  describe "PATCH update" do
    before do
      FactoryGirl.create :lesson
    end

    context "valid params" do
      it "updates lesson" do
        patch :update, course_id: 1, id: 1,
        lesson: { lesson_category_id: 1, content: "rt", name: "RIP" }
        expect(Lesson.first.name).to eq "RIP"
        expect(response).to redirect_to course_lesson_path 1, 1
      end
    end

    context "invalid params" do
      it "does not create params" do
        patch :update, course_id: 1, id: 1,
        lesson: { lesson_category_id: 1, content: "rt", name: "" }
        expect(Lesson.first.name).not_to eq ""
        expect(response).to render_template :edit
      end
    end
  end

end
