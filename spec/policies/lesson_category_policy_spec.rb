require 'rails_helper'

describe LessonCategoryPolicy do

  subject { LessonCategoryPolicy }

  permissions :destroy?, :create?, :update? do
    context 'owner' do
      before do
        @user = double User
        @course = double Course, owners: [@user]
        @lc = double LessonCategory, course: @course
      end

      it 'grants access' do
        expect(subject).to permit(@user, @lc)
      end
    end
  end
end
