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

  permissions :settings?, :update?, :send_invitation?, :toggle_flag? do
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

  permissions :update_attending?, :remove_user?, :destroy? do
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

  permissions :add_user?, :check_password? do
    context 'private course' do
      it 'denies access' do
        course = double Course, private: true, users: []
        expect(subject).not_to permit(double(User), course)
      end
    end

    context 'open course' do
      it 'grants access' do
        course = double Course, private: false, users: []
        expect(subject).to permit(double(User), course)
      end
    end

    context 'already a member' do
      it 'grants access' do
        user = double User
        course = double Course, private: true, users: [user]
        expect(subject).to permit(user, course)
      end
    end
  end

  permissions :remove_self? do
    before do
      @user = double User
      @course = double Course, users: [@user], owners: []
    end
    context 'course memmber' do
      it 'grants access' do
        expect(subject).to permit(@user, @course)
      end
    end

    context 'course owner' do
      before do
        allow(@course).to receive(:owners).and_return([@user])
      end

      it 'does not grant access' do
        expect(subject).not_to permit(@user, @course)
      end
    end
  end

  describe '.Scope' do
    before do
      FactoryGirl.create :course
      FactoryGirl.create :course, name: "foo"
      FactoryGirl.create :course, name: "12", private: true
      FactoryGirl.create :course, name: "34", private: true
      @user = FactoryGirl.create :user
      Attending.create(course_id: 1, user_id: 1)
      Attending.create(course_id: 3, user_id: 1)
    end
    it 'includes right courses' do
      expect(CoursePolicy::Scope.new(@user, Course).resolve.sort).to(
        eq [Course.first, Course.second, Course.find(3)].sort
      )
    end
  end
end
