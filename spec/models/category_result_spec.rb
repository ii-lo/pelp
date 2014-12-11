# == Schema Information
#
# Table name: category_results
#
#  id                   :integer          not null, primary key
#  user_exam_id         :integer
#  question_category_id :integer
#  value                :decimal(, )      default(0.0)
#  created_at           :datetime
#  updated_at           :datetime
#

require 'rails_helper'

RSpec.describe CategoryResult, :type => :model do
  describe 'validation' do
    it { is_expected.to validate_presence_of :user_exam_id }

    it { is_expected.to validate_presence_of :question_category_id }

    it { is_expected.to validate_uniqueness_of(:question_category_id).
         scoped_to [:user_exam_id] }
  end
end
