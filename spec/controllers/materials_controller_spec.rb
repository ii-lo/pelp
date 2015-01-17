require 'rails_helper'

RSpec.describe MaterialsController, :type => :controller do

  before do
    FactoryGirl.create :user
    sign_in User.first
    FactoryGirl.create :course
    FactoryGirl.create :attending, role: 2
    FactoryGirl.create :lesson_category
    FactoryGirl.create :material_category
    @file = Rack::Test::UploadedFile.new File.join(Rails.root, "/spec/factories/paperclip", "pelp.png"), 'image/png'
  end
  describe "POST new" do
    context "valid" do
      it "creates material" do
        expect do
          post :create, course_id: 1, material_category_id: 1,
            material: { name: "name", file: @file }
        end.to change(Material, :count).by(1)
        expect(response).to redirect_to course_material_category_path(1, 1)
      end
    end

    context "invalid" do
      it "does not create material" do
        expect do
          post :create, course_id: 1, material_category_id: 1,
            material: { name: "name" }
        end.not_to change(Material, :count)
        expect(response).to redirect_to course_material_category_path(1, 1)
      end
    end
  end

  describe "DELETE destroy" do
    before do
      FactoryGirl.create :material
    end

    it "removes material" do
      expect do
        delete :destroy, course_id: 1, material_category_id: 1, id: 1
      end.to change(Material, :count).by(-1)
    end
  end
end
