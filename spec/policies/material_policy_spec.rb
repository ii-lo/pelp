require 'rails_helper'

describe MaterialPolicy do

  subject { MaterialCategoryPolicy }

  permissions :create?, :destroy? do
    before do
      @user = double User
      @course = double Course, admins: [@user]
      @material = double Material, course: @course
    end

    context "course member" do
      it "grants access" do
        expect(subject).to permit(@user, @material)
      end
    end

    context "not a course member" do
      it "denies access" do
        allow(@course).to receive(:admins).and_return([])
        expect(subject).not_to permit(@user, @material)
      end
    end
  end

end
