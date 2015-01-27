require 'rails_helper'

RSpec.describe UserPolicy do
  subject { described_class }

  permissions :show? do
    it "denies access if post not logged in" do
      expect(subject).not_to permit(nil, User.new)
    end

    it "grants access if logged in" do
      expect(subject).to permit(User.new, User.new)
    end
  end

  permissions :create? do
    it "denies access if post logged in" do
      expect(subject).not_to permit(User.new, User.new)
    end

    it "grants access if not logged in" do
      expect(subject).to permit(nil, User.new)
    end
  end

  permissions :new? do
    it "denies access if post logged in" do
      expect(subject).not_to permit(User.new, User.new)
    end

    it "grants access if not logged in" do
      expect(subject).to permit(nil, User.new)
    end
  end

  permissions :edit?, :update?, :change_password? do
    context "same user" do
      it "grants access" do
        user = User.new
        expect(subject).to permit(user, user)
      end
    end

    context "other user" do
      it "denies access" do
        expect(subject).not_to permit(User.new, User.new)
      end
    end
  end
end
