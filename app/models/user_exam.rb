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

  has_many :user_answers, dependent: :destroy
  has_many :category_results, dependent: :destroy
  has_one :course, through: :exam

  validates :user_id, presence: true
  validates :exam_id, presence: true

  delegate :duration, to: :exam, prefix: true

  def update_result
    sum = 0
    q_c = exam.question_categories.pluck(:id)
      .each_with_object({}) { |question, h| h[question] = 0 }
    user_answers.includes(:question)
      .group_by(&:question).each do |question, user_answers|
      result = mark_answer(question, user_answers)
      sum += result
      q_c[question.question_category_id] += result
    end
    update_attribute(:result, sum)
    update_category_results(q_c)
    sum
  end

  def open?
    !closed
  end

  def close!
    return :already_closed if closed
    update_attribute(:closed, true)
    update_result
  end

  def wait_for_close!
    close!
  end

  handle_asynchronously :wait_for_close!, run_at: proc { |ue| ue.exam.duration.seconds.from_now },
    priority: 20

  private

  def mark_answer(question, user_answers)
    case question.form
    when 'multiple'
      mark_multiple(question, user_answers)
    else
      user_answers.first.correct ? question.value : 0
    end
  end

  def mark_multiple(question, user_answers)
    return 0 if question.correct_answers_count == 0
    correct, wrong = 0, 0
    user_answers.each do |i|
      next if i.answer_id.blank?
      i.correct ? correct += 1 : wrong += 1
    end
    diff = correct > wrong ? correct - wrong : 0
    (diff.to_f) * question.value / question.correct_answers_count
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
