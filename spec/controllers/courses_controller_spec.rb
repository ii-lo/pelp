require 'rails_helper'

RSpec.describe CoursesController, :type => :controller do

  before do
    @user = FactoryGirl.create :user
    sign_in @user
  end

  describe "GET index" do
    context 'params search' do
      it 'return http success' do
        get :index, search: "Hehe"
        expect(response).to have_http_status(:success)
      end
    end
    context 'no params search' do
      it "returns http success" do
        get :index
        expect(response).to have_http_status(:success)
      end
    end
  end

  describe "GET new" do
    it 'have success response' do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST create" do
    context 'valid' do
      it 'creates course' do
        expect do
          post :create, course: {
            name: "12345", description: "aa", password: "123456a"
          }
        end.to change(Course, :count).by(1).and(
          change(Attending, :count).by(1)
        )
        c = Course.first
        expect(c.private).to eq false
        expect(c.password).to eq '123456a'
        expect(c.description).to eq 'aa'
        expect(response).to redirect_to course_path(1)
      end
    end

    context 'invalid' do
      it 'renders new' do
        expect do
          post :create, course: {
            name: "", description: "aaa", password: "123456"
          }
        end.not_to change(Course, :count)
        expect(response).to render_template :new
      end
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

    context 'own attending' do
      it 'does not update_attending' do
        post :update_attending, id: 1, attending: { role: 0, user_id: 1 }
        expect(Attending.first.role).not_to eq "member"
      end
    end

    context 'updating of other user' do
      it "updates_attending" do
        post :update_attending, id: 1, attending: { role: 0, user_id: 2 }
        expect(Attending.second.role).to eq "member"
      end
    end
  end

  describe 'POST send_invitation' do
    before do
      FactoryGirl.create :course
      Attending.create(course_id: 1, user_id: 1, role: 1)
    end
    context 'new email' do
      it 'sends invitation' do
        message = spy
        expect(InvitationMailer).to receive(:invite) { message }
        expect(message).to receive :deliver_later
        post :send_invitation, id: 1, invitation: { email: 'bronislaw@gmail.com' }
      end
    end

    context 'existing email' do
      it 'does not send invitation' do
        post :send_invitation, id: 1, invitation: { email: User.first.email }
        expect(InvitationMailer).not_to receive(:invite)
      end
    end
  end

  describe "GET add_user" do
    before do
      FactoryGirl.create(:course)
    end

    context 'already course member' do
      before do
        Attending.create(user_id: 1, course_id: 1)
      end

      it 'redirects to show' do
        get :add_user, id: 1
        expect(response).to redirect_to course_path(1)
      end
    end

    context 'blank password' do
      it 'adds user to course' do
        expect do
          get :add_user, id: 1
        end.to change(Attending, :count).by(1)
        expect(response).to redirect_to course_path(1)
      end
    end

    context 'password' do
      before do
        Course.first.update_attribute(:password, "123456")
      end

      it 'renders form' do
        get :add_user, id: 1
        expect(response).to have_http_status 200
      end
    end
  end

  describe "POST check_password" do
    before do
      FactoryGirl.create(:course, password: "123456")
    end
    context 'correct password' do
      it 'adds user to course' do
        expect do
          post :check_password, id: 1, course: { password: "123456" }
        end.to change(Attending, :count).by(1)
        expect(response).to redirect_to course_path(1)
      end
    end

    context 'incorrect passowrd' do
      it 'renders form' do
        post :check_password, id: 1, course: { password: "1" }
        expect(response).to render_template :add_user
      end
    end
  end

  describe "GET remove_user" do
    before do
      FactoryGirl.create :course
      Attending.create(course_id: 1, role: 2, user_id: 1)
      FactoryGirl.create :user, email: "kk@kk.com"
      Attending.create(user_id: 2, course_id: 1)
    end

    context 'other user' do
      it 'removes user from course' do
        expect do
          get :remove_user, id: 1, user_id: 2
        end.to change(Attending, :count).by(-1)
        expect(response).to redirect_to settings_course_path(1)
      end
    end

    context 'same user' do
      it 'does not remove user from course' do
        expect do
          get :remove_user, id: 1, user_id: 1
        end.not_to change(Attending, :count)
        expect(response).to redirect_to settings_course_path(1)
      end
    end
  end

  describe 'GET toggle_flag' do
    before do
      FactoryGirl.create :course
      FactoryGirl.create :lesson_category
      Attending.create(course_id: 1, role: 1, user_id: 1)
    end

    it 'toggles lesson category flag' do
      flag = LessonCategory.first.flagged
      get :toggle_flag, id: 1, lesson_category_id: 1
      expect(LessonCategory.first.flagged).to eq !flag
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
