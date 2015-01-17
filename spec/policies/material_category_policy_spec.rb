require 'rails_helper'

describe MaterialCategoryPolicy do

  let(:user) { User.new }

  subject { MaterialCategoryPolicy }

  [:create?, :update?, :destroy?, :new?].each do |sym|
    permissions sym do
      before do
        @user = double User
        @course = double Course, admins: [@user]
        @m_c = double MaterialCategory, course: @course
      end

      context "course admin" do
        it "grants access" do
          expect(subject).to permit(@user, @m_c)
        end
      end

      context "not a course admin" do
        it "denies access" do
          allow(@course).to receive(:admins).and_return([])
          expect(subject).not_to permit(@user, @m_c)
        end
      end
    end
  end

  permissions :show? do
    before do
      @user = double User
      @course = double Course, users: [@user]
      @m_c = double MaterialCategory, course: @course
    end

    context "course member" do
      it "grants access" do
        expect(subject).to permit(@user, @m_c)
      end
    end

    context "not a course member" do
      it "denies access" do
        allow(@course).to receive(:users).and_return([])
        expect(subject).not_to permit(@user, @m_c)
      end
    end
  end
end
