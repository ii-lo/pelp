require 'rails_helper'

RSpec.describe StaticPagesController, :type => :controller do

  describe "GET home" do
    it "returns http success" do
      get :home
      expect(response).to be_success
    end
  end

  describe "GET help" do
    it "returns http success" do
      get :help
      expect(response).to be_success
    end
  end

  describe "GET privacy" do
    it "returns http success" do
      get :privacy
      expect(response).to be_success
    end
  end

end
