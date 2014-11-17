require 'rails_helper'

RSpec.describe MessagesController, :type => :controller do
  before do
    @user = FactoryGirl.create :user, email: "wp@wp.pl"
    sign_in @user
  end

  describe 'POST create' do
    before do
      FactoryGirl.create :user, email: "rr@ss.com"
    end
    context "valid" do
      context "one receiver" do
        it "creates message" do
          expect do
            post :create, message: {title: "To pan tik tak", body:
                            "a to jego znak", receivers: User.last.name.to_s}
          end.to change { Message.count }.by(1).and change { Sending.count }.by(1)
        end
      end
      context "many receivers" do
        before do
          FactoryGirl.create(:user, name: "Pan Jan", email: "asdf@lorem.com")
        end
        it "creates message" do
          expect do
            post :create, message: {title: "To pan tik tak", body:
                            "a to jego znak", receivers:
                                        "#{User.last.name}; #{User.second.name}"}
          end.to change { Message.count }.by(1).and change { Sending.count }.by(2)
        end
      end
      context "invalid" do
        context "one receiver" do
          it "does not create message" do
            expect do
              post :create, message: {title: "To pan tik tak", body:
                              "a to jego znak", receivers: "a" * 16}
            end.to change { Message.count }.by(0).and change { Sending.count }.by(0)
          end
        end

        context "many receivers" do
          context "one or more valid" do
            before do
              FactoryGirl.create(:user, name: "Pan Jan", email: "asdf@lorem.com")
            end

            it "creates message but doesn't create all sendings" do
              expect do
                post :create, message: {title: "To pan tik tak", body:
                                "a to jego znak",
                                        receivers: "#{User.second.name}; #{'ab' * 16}"}
              end.to change { Message.count }.by(1).and change { Sending.count }.by(1)
            end
          end

          context "all invalid" do
            it "does not create message and does not create sendings" do
              expect do
                post :create, message: {title: "To pan tik tak", body:
                                "a to jego znak",
                                        receivers: "#{'cd' * 5}; #{'ab' * 16}"}
              end.to change { Message.count }.by(0).and change { Sending.count }.by(0)
            end
          end
        end
      end
    end
  end

  describe 'GET index' do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe 'DELETE destroy' do
    before do
      request.env["HTTP_REFERER"] = "/"
    end
    context "current_user's message" do
      it "removes message with sendings" do
        FactoryGirl.create(:user, email: "as@example.com", name: "Murk Murk")
        Message.create(sender_id: 1, title: "asd", body: "asdf")
        Sending.create(user_id: 2, message_id: 1)
        expect do
          delete :destroy, id: 1
        end.to change { Message.count }.by(-1).and change { Sending.count }.by(-1)
      end
    end

    context "message sent to current_user" do
      it "removes only sending" do
        FactoryGirl.create(:user, email: "as@example.com", name: "Murk Murk")
        Message.create(sender_id: 2, title: "asd", body: "asdf")
        Sending.create(user_id: 1, message_id: 1)
        expect do
          delete :destroy, id: 1
        end.to change { Sending.count }.by(-1)
      end
    end
  end
end
