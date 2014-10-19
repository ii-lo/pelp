require 'rails_helper'

RSpec.describe CoursesController, :type => :controller do

  before do
    @user = FactoryGirl.create :user
    sign_in @user
  end

  describe "GET index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET show" do
    before do
      FactoryGirl.create :course
      Attending.create(course_id: 1, user_id: 1)
    end
    it "returns http success" do
      get :show, id: 1
      expect(response).to have_http_status(:success)
    end

    it "updates attending's last_visited" do
      a = spy(LastVisit.new)
      allow(LastVisit).to receive(:where) { a }
      expect(a).to receive(:update_date).once
      get :show, id: 1
    end
  end

end
