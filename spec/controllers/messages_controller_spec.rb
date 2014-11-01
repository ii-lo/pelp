require 'rails_helper'

RSpec.describe MessagesController, :type => :controller do
  before do
    @user = FactoryGirl.create :user
    sign_in @user
  end

  describe 'GET index' do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end
end
