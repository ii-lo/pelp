class UserExamWaitForCloseJob < ActiveJob::Base
  queue_as :default

  def perform(user_exam)
    user_exam.close!
  end
end
