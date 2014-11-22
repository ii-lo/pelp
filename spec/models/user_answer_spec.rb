# == Schema Information
#
# Table name: user_answers
#
#  id           :integer          not null, primary key
#  answer_id    :integer
#  user_exam_id :integer
#  correct      :boolean
#  created_at   :datetime
#  updated_at   :datetime
#  text         :string(255)
#  question_id  :integer
#

require 'rails_helper'

RSpec.describe UserAnswer, :type => :model do
  describe 'validation' do
    it { is_expected.to validate_presence_of :user_exam_id }

    it { is_expected.to validate_presence_of :question_id }
  end
end
