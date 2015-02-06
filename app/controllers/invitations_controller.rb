class InvitationsController < ApplicationController
  def accept
    @invitation = Invitation.find_by_slug(params[:slug])
    return redirect_to root_path unless @invitation
    if @user = User.where('LOWER("email") = ?',
        @invitation.email.downcase).take
      @user.attendings.create(course_id: @invitation.course_id)
      @invitation.destroy
      redirect_to root_path, notice: "Kurs został dodany"
    else
      @invitation.accept!
      redirect_to root_path, notice: "Kurs zostanie dodany po rejestracji"
    end
  end
end
