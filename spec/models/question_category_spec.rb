# == Schema Information
#
# Table name: question_categories
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

require 'rails_helper'

RSpec.describe QuestionCategory, :type => :model do
  describe 'validation' do
    it { is_expected.to validate_presence_of :name }
  end
end
