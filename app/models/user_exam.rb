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
  has_many :category_results
  has_one :course, through: :exam

  validates :user_id, presence: true
  validates :exam_id, presence: true

  def update_result
    sum = 0
    q_c = exam.question_categories.pluck(:id).each_with_object({}) { |q, m| m[q] = 0 }
    user_answers.includes(:question).
      group_by(&:question).each do |k, v|
      case k.form
      when 'multiple'
        res = mark_multiple(k, v)
      else
        res = v.first.correct ? k.value : 0
      end
      sum += res
      q_c[k.question_category_id] += res
    end
    update_attribute(:result, sum)
    update_category_results(q_c)
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

  private

  def mark_multiple(question, user_answers)
    correct, wrong = 0, 0
    user_answers.each do |i|
      i.correct ? correct += 1 : wrong += 1
    end
    diff = correct > wrong ? correct - wrong : 0
    (diff.to_f) * question.value / question.correct_answers.size
  end

  def update_category_results(categories)
    categories = categories.to_hash
    categories.each do |c, v|
      if cr = CategoryResult.where(user_exam_id: id, question_category_id: c).first
        cr.update_attribute(:value, v)
      else
        CategoryResult.create(user_exam_id: id, question_category_id: c,
                             value: v)
      end
    end
  end

end
