require 'rails_helper'

describe LessonPolicy do

  let(:user) { User.new }

  subject { LessonPolicy }

  permissions :new? do
    context "admin" do
      it "grants access to admins" do
        course = double Course, admins: [user]
        lesson = double Lesson, course: course
        expect(subject).to permit(user, lesson)
      end
    end

    context "not and admin" do
      it "does not grant access" do
        course = double Course, admins: [], users: [user]
        lesson = double Lesson, course: course
        expect(subject).not_to permit(user, lesson)
      end
    end
  end

  permissions :show? do
    context "member of course" do
      it "grants access" do
        course = double Course, users: [user]
        lesson = double Lesson, course: course
        expect(subject).to permit(user, lesson)
      end
    end

    context "not a member of course" do
      it "does not grant access" do
        course = double Course, users: []
        lesson = double Lesson, course: course
        expect(subject).not_to permit(user, lesson)
      end
    end
  end

  #permissions ".scope" do
    #pending "add some examples to (or delete) #{__FILE__}"
  #end
end
