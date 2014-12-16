require 'rails_helper'

describe ExamPolicy do

  let(:user) { User.new }

  subject { ExamPolicy }


  permissions :new? do
    it "it permits when course member(gonna change this)" do
      exam = double Exam
      course = double Course
      allow(course).to receive(:users) { [user] }
      allow(exam).to receive(:course) { course }
      expect(subject).to permit(user, exam)
    end

    it "does not permit when user is not course memeber" do
      exam = double :exam
      course = double Course
      allow(course).to receive(:users) { [] }
      allow(exam).to receive(:course) { course }
      expect(subject).not_to permit(user, exam)
    end
  end
end
