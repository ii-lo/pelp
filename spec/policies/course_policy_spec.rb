require 'rails_helper'

describe CoursePolicy do

  subject { CoursePolicy }

  permissions :index? do
    context "user signed" do
      it "grants access" do
        expect(subject).to permit(double(User), double(Course))
      end
    end

    context "user not signed" do
      it "denies access" do
        expect(subject).not_to permit(nil, double(Course))
      end
    end
  end

  permissions :show? do
    context "member of course" do
      it "grants access" do
        user = double User
        course = double Course, users: [user]
        expect(subject).to permit(user, course)
      end
    end

    context "not a member of course" do
      it "denies access" do
        user = double User
        course = double Course, users: []
        expect(subject).not_to permit(user, course)
      end
    end
  end

  permissions :settings?, :update?, :send_invitation? do
    context "admin" do
      it "grants access" do
        user = double User
        course = double Course, users: [user], admins: [user]
        expect(subject).to permit(user, course)
      end
    end

    context "not an admin" do
      it "denies access" do
        user = double User
        course = double Course, users: [user], admins: []
        expect(subject).not_to permit(user, course)
      end
    end
  end

  permissions :update_attending? do
    context "owner" do
      it "grants access" do
        user = double User
        course = double Course, users: [user], admins: [user], owners:[user]
        expect(subject).to permit(user, course)
      end
    end

    context "not an owner" do
      it "denies access" do
        user = double User
        course = double Course, users: [user], admins: [user], owners: []
        expect(subject).not_to permit(user, course)
      end
    end
  end
end
