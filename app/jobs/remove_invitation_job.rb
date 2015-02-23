class RemoveInvitationJob < ActiveJob::Base
  queue_as :default

  def perform(invitation)
    invitation.destroy
  end
end
