require 'rails_helper'

RSpec.describe InvitationsController, :type => :controller do

  describe "GET accept" do
    context 'no params slug' do
      it 'redirects to root_path' do
        get :accept
        expect(response).to redirect_to root_path
      end
    end

    context 'params slug' do
      before do
        FactoryGirl.create :course
        FactoryGirl.create :user
        @inv = FactoryGirl.create :invitation, email: 'example@ss.com'
      end

      context 'user with mail exists' do
        it 'adds course to users courses' do
          expect do
            get :accept, slug: @inv.slug
          end.to change(Invitation, :count).by(-1)
          expect(User.first.courses).to include Course.first
          expect(response).to redirect_to root_path
        end
      end

      context 'user does not exist' do
        before do
          User.first.destroy
        end
        it 'accept invitation' do
          get :accept, slug: @inv.slug
          expect(Invitation.first.accepted).to eq true
          expect(response).to redirect_to root_path
        end
      end
    end
  end

end
