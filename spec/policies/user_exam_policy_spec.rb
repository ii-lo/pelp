require 'rails_helper'

describe UserExamPolicy do

  let(:user) { User.new }

  subject { UserExamPolicy }

  permissions :new?, :start? do
    before do
      FactoryGirl.create :user
      FactoryGirl.create :course
      FactoryGirl.create :attending
      FactoryGirl.create :lesson_category
      FactoryGirl.create :exam
      @user_exam = FactoryGirl.build :user_exam
    end

    context "user does not attend to course" do
      it "denies when not attending to course" do
        expect(subject).not_to permit(User.new, @user_exam)
      end
    end

    context "user attends to course" do
      it "grants access" do
        expect(subject).to permit(User.first, @user_exam)
      end
    end

    context "one_run" do
      before do
        Exam.first.update_attribute(:one_run, true)
      end
      context "first user_exam" do
        it "grants access" do
          expect(subject).to permit(User.first, @user_exam)
        end
      end

      context "nth exam" do
        before do
          FactoryGirl.create :user_exam
        end

        it "denies access" do
          expect(subject).not_to permit(User.first, @user_exam)
        end
      end
    end
  end

  permissions :question?, :answer? do
    before do
      FactoryGirl.create :user
      FactoryGirl.create :course
      FactoryGirl.create :attending
      FactoryGirl.create :lesson_category
      FactoryGirl.create :exam
      @user_exam = FactoryGirl.create :user_exam
    end

    context "one run" do
      before do
        @user_exam.exam.update_attribute(:one_run, true)
      end

      context "first run" do
        context "same user" do
          it "grants access" do
            expect(subject).to permit(User.first, @user_exam)
          end
        end

        context "not the same user" do
          it "denies access" do
            expect(subject).not_to permit(User.new, @user_exam)
          end
        end
      end

      context "nth run" do
        before do
          FactoryGirl.create :user_exam
        end

        it "denies access" do
          expect(subject).not_to permit(User.first, @user_exam)
        end
      end
    end
  end

  permissions :show? do
    before do
      @user = double User
      @course = double Course, admins: []
      @exam = double Exam, one_run: false
      @user_exam = double UserExam, user: @user, closed: true, exam: @exam,
        course: @course
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

    context 'admin' do
      before do
        allow(@course).to receive(:admins).and_return([@user])
      end

      it 'grants access' do
        expect(subject).to permit(@user, @user_exam)
      end
    end
  end

  permissions :exit? do
    before do
      @user = double User
      @exam = double Exam, one_run: false
      @user_exam = double UserExam, user: @user, closed: true, exam: @exam
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
  end

  permissions :edit?, :correct_answer? do
    before do
      @user = double User
      @course = double Course, admins: []
      @exam = double Exam, one_run: false
      @user_exam = double UserExam, user: @user, closed: true, exam: @exam,
        course: @course, closed?: true
    end

    context 'not an admin' do
      it 'denies access' do
        expect(subject).not_to permit(@user, @user_exam)
      end
    end

    context 'admin' do
      before do
        allow(@course).to receive(:admins) { [@user] }
      end
      context 'closed exam' do
        it 'grants access' do
          expect(subject).to permit(@user, @user_exam)
        end
      end

      context 'during exam' do
        before do
          allow(@user_exam).to receive_messages(closed: false, closed?: false)
        end
        it 'denies access' do
          expect(subject).not_to permit(@user, @user_exam)
        end
      end
    end
  end
end
