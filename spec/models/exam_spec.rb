# == Schema Information
#
# Table name: exams
#
#  id                 :integer          not null, primary key
#  name               :string(255)
#  course_id          :integer
#  created_at         :datetime
#  updated_at         :datetime
#  lesson_category_id :integer
#  duration           :integer
#  max_points         :integer          default("0")
#  published          :boolean          default("f")
#  one_run            :boolean          default("f")
#

require 'rails_helper'

RSpec.describe Exam, :type => :model do
  describe 'validation' do

    before do
      FactoryGirl.create :lesson_category
    end

    subject { FactoryGirl.build :exam }

    it { is_expected.to validate_presence_of :name }

    it { is_expected.to validate_presence_of :lesson_category_id }

    it { is_expected.to validate_presence_of :duration }

    it do
      is_expected.to validate_uniqueness_of(:lesson_category_id).
        scoped_to :name
    end
  end
end

