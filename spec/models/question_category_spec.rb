# == Schema Information
#
# Table name: question_categories
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#  exam_id    :integer
#

require 'rails_helper'

RSpec.describe QuestionCategory, :type => :model do
  describe 'validation' do
    it { is_expected.to validate_presence_of :name }

    it { is_expected.to validate_presence_of :exam }

    it { is_expected.to validate_uniqueness_of(:name).scoped_to([:exam_id]) }
  end
end
