# == Schema Information
#
# Table name: lessons
#
#  id                 :integer          not null, primary key
#  name               :string(255)
#  created_at         :datetime
#  updated_at         :datetime
#  lesson_category_id :integer
#  course_id          :integer
#  content            :text             default("")
#

require 'rails_helper'

RSpec.describe Lesson, :type => :model do
  describe 'validation' do
    it { is_expected.to validate_presence_of :name }

    it { is_expected.to validate_presence_of :lesson_category_id }
  end
end
