# == Schema Information
#
# Table name: user_exams
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  exam_id    :integer
#  created_at :datetime
#  updated_at :datetime
#  result     :decimal(, )      default(0.0)
#

require 'rails_helper'

RSpec.describe UserExam, :type => :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
