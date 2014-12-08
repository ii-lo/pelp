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
#  closed     :boolean          default(FALSE)
#

class UserExam < ActiveRecord::Base
  belongs_to :user
  belongs_to :exam

  has_many :user_answers
  has_one :course, through: :exam

  validates :user_id, presence: true
  validates :exam_id, presence: true

  def update_result
    sum = 0
    user_answers.includes(:question).
        group_by(&:question).each do |k, v|
      case k.form
        when 'multiple'
          correct, wrong = 0, 0
          v.each do |i|
            i.correct ? correct += 1 : wrong += 1
          end
          diff = correct > wrong ? correct - wrong : 0
          sum += (diff.to_f) * k.value / k.correct_answers.size
        else
          sum += k.value if v.first.correct
      end
    end
    update_attribute(:result, sum)
  end

  def open?
    !closed
  end

  def close!
    update_attribute(:closed, true)
    update_result
  end

  def wait_for_close!
    unless closed
      close!
    end
  end

  handle_asynchronously :wait_for_close!, run_at: Proc.new { |ue| ue.exam.duration.seconds.from_now },
                        priority: 20

end
