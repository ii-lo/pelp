require 'rails_helper'

RSpec.describe UserExamsController, :type => :controller do
  before do
    @user = FactoryGirl.create :user, email: "wp@wp.pl"
    sign_in @user
    FactoryGirl.create :course
    FactoryGirl.create :lesson_category
    FactoryGirl.create :exam
    FactoryGirl.create :question
  end

  describe "GET new" do
    it "returns http success" do
      get :new, id: 1
      expect(assigns(:exam)).to eq Exam.first
      expect(response).to redirect_to question_user_exam_path
    end
  end

  describe "GET question" do
    before do
      get :new, id: 1
    end
    it "returns http success" do
      get :question
      expect(response).to have_http_status(:success)
    end
  end

end
