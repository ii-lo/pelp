require 'rails_helper'

describe ExamPolicy do

  let(:user) { User.new }

  subject { ExamPolicy }


  permissions :new? do
    it "it permits when course admin" do
      exam = double Exam
      course = double Course
      allow(course).to receive(:admins) { [user] }
      allow(exam).to receive(:course) { course }
      expect(subject).to permit(user, exam)
    end

    it "does not permit when user is not course memeber" do
      exam = double :exam
      course = double Course
      allow(course).to receive(:admins) { [] }
      allow(exam).to receive(:course) { course }
      expect(subject).not_to permit(user, exam)
    end
  end

  describe "Scope" do
    before do
      @user = FactoryGirl.create(:user)
      FactoryGirl.create :course
      FactoryGirl.create :course
      FactoryGirl.create :attending, role: 2
      FactoryGirl.create :attending, course_id: 2
      FactoryGirl.create :lesson_category
      FactoryGirl.create :lesson_category, course_id: 2
      FactoryGirl.create :exam, course_id: 1
      FactoryGirl.create :exam, lesson_category_id: 2, name: "Street"
      FactoryGirl.create :exam, lesson_category_id: 2, published: true
    end
    it "returns correct exams" do
      expect(ExamPolicy::Scope.new(@user, Exam).resolve).to(
        eq [Exam.first, Exam.last]
      )
    end
  end
end
