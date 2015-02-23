class InvitationMailer < ApplicationMailer
  def invite(invitation, request)
    InvitationMailer.default_url_options[:host] = request.host_with_port
    @invitation = invitation
    mail to: @invitation.email, subject: "PELP: zaproszono do kursu"
  end
end
