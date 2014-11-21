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
#

require 'rails_helper'

RSpec.describe UserAnswer, :type => :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
