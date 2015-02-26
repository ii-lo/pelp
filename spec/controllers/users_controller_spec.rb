require 'rails_helper'

RSpec.describe UsersController, :type => :controller do

  describe "GET new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST create" do
    context "valid user" do
      it "creates user" do
        expect do
          post :create, user: FactoryGirl.attributes_for(:user)
        end.to change { User.count }.by(1)
        expect(response).to redirect_to root_path
      end
    end

    context "invalid" do
      it "does not create user" do
        expect do
          post :create, user: FactoryGirl.attributes_for(:user, email: "22")
        end.not_to change { User.count }
        expect(response).to render_template :new
      end
    end
  end

  describe "GET show" do
    before do
      @user = FactoryGirl.create :user
      sign_in @user
    end

    it "returns http success and assigns user" do
      get :show, id: 1
      expect(response).to have_http_status(:success)
      expect(assigns(:user)).to eq User.find(1)
    end
  end

  describe "GET edit" do
    before do
      @user = FactoryGirl.create :user
      sign_in @user
    end

    it "returns http success" do
      get :edit, id: 1
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET update" do
    before do
      @user = FactoryGirl.create :user
      sign_in @user
    end

    context "correct current_password" do
      it "updates user" do
        patch :update, id: 1, user: {
          current_password: FactoryGirl.build(:user).password,
          email: 'rob@rob.com',
          name: "Testo"
        }
        expect(User.first.name).to eq "Testo"
        expect(User.first.email).to eq "rob@rob.com"
        expect(response).to redirect_to edit_user_path(User.first)
      end
    end

    context "incorrect current_password" do
      it "does not update user" do
        patch :update, id: 1, user: {
          current_password: '12',
          name: "Testo"
        }
        expect(User.first.name).not_to eq "Testo"
        expect(response).to render_template :edit
      end
    end

    context 'invalid params' do
      it 'renders edit template' do
        patch :update, id: 1, user: {
          current_password: FactoryGirl.build(:user).password,
          email: 'rob@rob.com',
          name: ""
        }
        expect(response).to render_template :edit
      end
    end
  end

  describe "PATCH change_password" do
    before do
      @user = FactoryGirl.create :user
      sign_in @user
    end

    context "valid current password" do
      context "valid new password" do
        it "updates password" do
          patch :change_password, id: 1, user: {
            current_password: FactoryGirl.build(:user).password,
            password: "razdwatrzy",
            password_confirmation: "razdwatrzy"
          }
          expect(User.first.valid_password?("razdwatrzy")).to eq true
          expect(response).to redirect_to edit_user_path(User.first)
        end
      end

      context "invalid new password" do
        it "does not update password" do
          patch :change_password, id: 1, user: {
            current_password: FactoryGirl.build(:user).password,
            password: "razdwatrzy",
            password_confirmation: ""
          }
          expect(User.first.valid_password?("razdwatrzy")).to eq false
          expect(response).to render_template :edit
        end
      end
    end

    context "invalid current password" do
      it "does not update password" do
        patch :change_password, id: 1, user: {
          password: "razdwatrzy",
          password_confirmation: "razdwatrzy"
        }
        expect(User.first.valid_password?("razdwatrzy")).to eq false
        expect(response).to render_template :edit
      end
    end
  end

  describe "POST destroy" do
    before do
      @user = FactoryGirl.create :user
      sign_in @user
    end
    context "correct current password" do
      it "removes user" do
        expect do
          post :destroy, id: 1, user: {
            current_password: FactoryGirl.build(:user).password
          }
        end.to change(User, :count).by(-1)
        expect(response).to redirect_to root_path
      end
    end

    context "incorrect current password" do
      it "does not remove user" do
        expect do
          post :destroy, id: 1, user: {
            current_password: '1'
          }
        end.not_to change(User, :count)
        expect(response).to render_template :edit
      end
    end
  end

end
