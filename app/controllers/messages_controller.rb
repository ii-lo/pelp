class MessagesController < ApplicationController
  def index
    @user = current_user
    @unread = @user.received_messages.paginate(per_page: 30, page: params[:received_page]) # gonna improve that
    @sent = @user.sent_messages.paginate(per_page: 30, page: params[:sent_page])
  end
end
