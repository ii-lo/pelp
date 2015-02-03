class InvitationMailer < ApplicationMailer
  def invite(email, course, user, invitation)
    @email = email
    @course = course
    @user = user
    @invitation = invitation

    mail to: @email, subject: "PELP: zaproszono do kursu"
  end
end
