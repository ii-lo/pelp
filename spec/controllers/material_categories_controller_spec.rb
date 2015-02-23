require 'rails_helper'

RSpec.describe MaterialCategoriesController, :type => :controller do

  before do
    FactoryGirl.create :user
    sign_in User.first
    FactoryGirl.create :course
    FactoryGirl.create :attending, role: 2
    FactoryGirl.create :lesson_category
  end

  describe "POST create" do
    context "valid material category" do
      it "saves and redirects to show" do
        expect do
          post :create, course_id: 1, material_category: {
            name: "Nazwa", lesson_category_id: 1
          }
        end.to change(MaterialCategory, :count).by(1)
        expect(response).to redirect_to(
          course_material_category_path(1, 1)
        )
      end
    end

    context "invalid" do
      it "renders new" do
        expect do
          post :create, course_id: 1, material_category: {
            name: "", lesson_category_id: 1
          }
        end.not_to change(MaterialCategory, :count)
        expect(response).to render_template :new
      end
    end
  end

  describe "GET new" do
    it "returns http success" do
      get :new, course_id: 1
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET show' do
    before do
      FactoryGirl.create :material_category
    end
    it "returns http success" do
      get :show, course_id: 1, id: 1
      expect(response).to have_http_status(:success)
    end
  end

  describe "PATCH update" do
    before do
      FactoryGirl.create :material_category
    end

    context "valid" do
      it "updates attributes" do
        patch :update, course_id: 1, id: 1, material_category: {
          name: "Mist", lesson_category_id: 1
        }
        expect(MaterialCategory.find(1).name).to eq "Mist"
        expect(response).to redirect_to course_material_category_path(1, 1)
      end
    end

    context "invalid" do
      it "does not update attributes" do
        patch :update, course_id: 1, id: 1, material_category: {
          name: "", lesson_category_id: 1
        }
        expect(MaterialCategory.find(1).name).not_to eq ""
        expect(response).to render_template :show
      end
    end
  end

  describe "DELETE destroy" do
    before do
      FactoryGirl.create :material_category
    end

    it "deletes material_category" do
      expect do
        delete :destroy, course_id: 1, id: 1
      end.to change(MaterialCategory, :count).by(-1)
    end
  end

  #describe "GET destroy" do
    #it "returns http success" do
      #get :destroy
      #expect(response).to have_http_status(:success)
    #end
  #end

  #describe "GET update" do
    #it "returns http success" do
      #get :update
      #expect(response).to have_http_status(:success)
    #end
  #end

end
