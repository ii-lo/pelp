require 'rails_helper'

describe UserExamPolicy do

  let(:user) { User.new }

  subject { UserExamPolicy }

  permissions :new? do
    before do
      @course = double(Course, users: [])
      @user_exam = double(UserExam, course: @course)
    end

    context "user does not attend to course" do
      it "denies when not attending to course" do
        expect(subject).not_to permit(User.new, @user_exam)
      end
    end

    context "user attends to couese" do
      before do
        @user = double User
        allow(@course).to receive(:users).and_return([@user])
      end
      it "grants access" do
        expect(subject).to permit(@user, @user_exam)
      end
    end


  end

  permissions :show? do
    before do
      @user = double User
      @user_exam = double UserExam, user: @user, closed: true
    end

    context "user's exam" do
      it "grants access" do
        expect(subject).to permit(@user, @user_exam)
      end
    end

    context "not user's exam" do
      before do
        allow(@user_exam).to receive(:user).and_return(User.new)
      end

      it "does not grant access" do
        expect(subject).not_to permit(@user, @user_exam)
      end
    end

    context "open exam" do
      before do
        allow(@user_exam).to receive(:closed).and_return false
      end

      it "does not grant access" do
        expect(subject).not_to permit(@user, @user_exam)
      end
    end
  end
end
