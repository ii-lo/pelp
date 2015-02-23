# == Schema Information
#
# Table name: lesson_categories
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  course_id  :integer
#  created_at :datetime
#  updated_at :datetime
#  flagged    :boolean          default("f")
#

require 'rails_helper'

RSpec.describe LessonCategory, :type => :model do
  describe 'validation' do
    it { is_expected.to validate_presence_of :course_id }
  end
end
