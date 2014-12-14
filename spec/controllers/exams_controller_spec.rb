require 'rails_helper'

RSpec.describe ExamsController, :type => :controller do
  before do
    @user = FactoryGirl.create :user, email: "wp@wp.pl"
    sign_in @user
    FactoryGirl.create :course
    FactoryGirl.create :lesson_category
    QuestionCategory.create(name: 'a', exam_id: 1)
    Attending.create(user_id: 1, course_id: 1, role_id: 0)
  end

  describe "GET new" do
    it "returns http success" do
      get :new, course_id: 1
      expect(response).to have_http_status(:success)
    end
  end

end
