# == Schema Information
#
# Table name: user_exams
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  exam_id    :integer
#  created_at :datetime
#  updated_at :datetime
#

class UserExam < ActiveRecord::Base
  belongs_to :user
  belongs_to :exam
end
