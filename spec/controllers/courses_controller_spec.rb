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
      a = spy(Attending.new)
      allow(Attending).to receive(:where) { a }
      expect(a).to receive(:update_last_visit).once
      get :show, id: 1
    end
  end

  describe 'GET settings' do
    before do
      FactoryGirl.create :course
      Attending.create(course_id: 1, user_id: 1, role: 2)
    end
    it "returns http success" do
      get :settings, id: 1
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST update' do
    before do
      FactoryGirl.create :course
      Attending.create(course_id: 1, user_id: 1, role: 2)
    end

    it "updates course" do
      post :update, id: 1, course: { name: "Just a name", description: "Kta" }
      expect(Course.first.name).to eq "Just a name"
      expect(Course.first.description).to eq "Kta"
    end
  end

  describe "POST update_attending" do
    before do
      FactoryGirl.create :course
      Attending.create(course_id: 1, user_id: 1, role: 2)
      FactoryGirl.create :user, email: "p@p.com"
      Attending.create(course_id: 1, user_id: 2, role: 1)
    end
    it "updates_attending" do
      post :update_attending, id: 1, attending: { role: 0, user_id: 2 }
      expect(Attending.second.role.to_i).to eq 0
    end
  end

  #describe 'GET exam' do
    #before do
      #FactoryGirl.create :course
      #Attending.create(course_id: 1, user_id: 1)
      #FactoryGirl.create :lesson_category
      #FactoryGirl.create :exam
    #end
    #it "returns http success" do
      #get :exam, id: 1, exam_id: 1
      #expect(response).to have_http_status(:success)
    #end
  #end

end
