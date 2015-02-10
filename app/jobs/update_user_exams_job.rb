class UpdateUserExamsJob < ActiveJob::Base
  queue_as :default

  def perform(exam)
    exam.user_exams.each(&:update_result)
  end
end
