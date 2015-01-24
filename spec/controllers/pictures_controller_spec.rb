require 'rails_helper'

RSpec.describe PicturesController, :type => :controller do
  before do
    FactoryGirl.create :user
    sign_in User.first
    FactoryGirl.create :course
    FactoryGirl.create :attending, role: 2
    FactoryGirl.create :lesson_category
    FactoryGirl.create :lesson
    @file = Rack::Test::UploadedFile.new File.join(Rails.root, "/spec/factories/paperclip", "pelp.png"), 'image/png'
  end

  describe "POST #new" do
    it "creates picture" do
      expect do
        post :create, course_id: 1, lesson_id: 1,
          picture: { file: @file }
      end.to change(Picture, :count).by(1)
    end
  end

  describe "DELETE #destroy" do
    before do
      FactoryGirl.create :picture
    end

    it "destroys picture" do
      expect do
        delete :destroy, course_id: 1, lesson_id: 1, id: 1
      end.to change(Picture, :count).by(-1)
    end
  end

end
