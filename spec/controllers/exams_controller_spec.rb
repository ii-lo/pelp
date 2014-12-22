require 'rails_helper'

RSpec.describe ExamsController, :type => :controller do
  before do
    @user = FactoryGirl.create :user, email: "wp@wp.pl"
    sign_in @user
    FactoryGirl.create :course
    FactoryGirl.create :lesson_category
    QuestionCategory.create(name: 'a', exam_id: 1)
    FactoryGirl.create :attending
  end

  describe "GET new" do
    it "returns http success" do
      get :new, course_id: 1
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST create" do
    context "valid exam" do
      it "creates exam" do
        expect do
          post :create, course_id: 1, exam: {
            name: "Nazwa", lesson_category_id: 1, duration: 4444
          }
        end.to change(Exam, :count).by(1)
        expect(response).to redirect_to edit_course_exam_path(1, 1)
      end
    end

    context "invalid exam" do
      it "does not create exam" do
        expect do
          post :create, course_id: 1, exam: {
            name: "Nazwa", lesson_category_id: 1
          }
        end.not_to change(Exam, :count)
        expect(response).to render_template :new
      end
    end
  end

  describe "GET edit" do
    before do
      FactoryGirl.create :exam
    end

    it "returns http success" do
      get :edit, course_id: 1, id: 1
      expect(response).to have_http_status(:success)
    end
  end

  describe "PATCH update" do
    before do
      FactoryGirl.create :exam
    end

    context "valid params" do
      it "updates exam" do
        patch :update, course_id: 1, id: 1, exam: { name: "N",
       duration: 444, published: '1' }
        expect(Exam.first.name).to eq "N"
        expect(Exam.first.duration).to eq 444
        expect(Exam.first.published).to eq true
        expect(response).to redirect_to edit_course_exam_path(1, 1)
      end
    end

    context "invalid params" do
      it "does not update exam" do
        patch :update, course_id: 1, id: 1, exam: { name: "N" * 400,
       duration: 444, published: 0 }
        expect(Exam.first.name).not_to eq "N" * 400
        expect(response).to render_template 'edit'
      end
    end
  end

end
