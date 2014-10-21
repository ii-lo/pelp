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
        end.to change{User.count}.by(1)
        expect(response).to redirect_to root_path
      end
    end

    context "invalid" do
      it "does not create user" do
        expect do
          post :create, user: FactoryGirl.attributes_for(:user, email: "22")
        end.not_to change{User.count}
        expect(response).to render_template :new
      end
    end
  end

  describe "GET show" do
    before do
      @user = FactoryGirl.create :user
    end

    it "returns http success and assigns user" do
      get :show, id: 1
      expect(response).to have_http_status(:success)
      expect(assigns(:user)).to eq @user
    end
  end

  #describe "GET edit" do
    #it "returns http success" do
      #get :edit
      #expect(response).to have_http_status(:success)
    #end
  #end

  #describe "GET update" do
    #it "returns http success" do
      #get :update
      #expect(response).to have_http_status(:success)
    #end
  #end

  #describe "GET destroy" do
    #it "returns http success" do
      #get :destroy
      #expect(response).to have_http_status(:success)
    #end
  #end

end
