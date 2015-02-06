class InvitationMailer < ApplicationMailer
  def invite(invitation)
    @invitation = invitation
    mail to: @invitation.email, subject: "PELP: zaproszono do kursu"
  end
end
