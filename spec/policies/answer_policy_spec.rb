require 'rails_helper'

describe AnswerPolicy do

  let(:user) { User.new }

  subject { AnswerPolicy }
  permissions :create?, :update?, :destroy? do
    context "admin" do
      it "grants access" do
        course = double Course, admins: [user]
        exam = double Exam, course: course
        question = double Question, exam: exam
        expect(subject).to permit(user, question)
      end
    end

    context "not and admin" do
      it "rejects access" do
        course = double Course, admins: [User.new]
        exam = double Exam, course: course
        question = double question, exam: exam
        expect(subject).not_to permit(user, question)
      end
    end
  end

end
