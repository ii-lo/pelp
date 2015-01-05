require 'rails_helper'

describe QuestionCategoryPolicy do

  let(:user) { User.new }

  subject { QuestionCategoryPolicy }

  [:create?, :update?, :destroy?].each do |action|
    permissions action do
      context "admin" do
        it "grants access" do
          course = double Course, admins: [user]
          exam = double Exam, course: course
          q_c = double QuestionCategory, exam: exam
          expect(subject).to permit(user, q_c)
        end
      end

      context "not and admin" do
        it "rejects access" do
          course = double Course, admins: [User.new]
          exam = double Exam, course: course
          q_c = double QuestionCategory, exam: exam
          expect(subject).not_to permit(user, q_c)
        end
      end
    end
  end

end
