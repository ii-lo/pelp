class MessagesController < ApplicationController
  def index
    @user = current_user
    @unread = @user.received_messages.paginate(per_page: 30, page: params[:received_page]) # gonna improve that
    @sent = @user.sent_messages.paginate(per_page: 30, page: params[:sent_page])
  end

  def page
    @user = current_user
    @type = params[:type]
    puts @type
    @messages = case @type
                when 'sent'
                  params[:sent_page] = params[:page]
                  @user.sent_messages.paginate(per_page: 30,
                  page: params[:sent_page])
                else
                  params[:unread_page] = params[:page]
                  @user.received_messages.paginate(per_page: 30,
                  page: params[:unread_page])
                end
    respond_to do |format|
      format.js {  }
    end
  end
end
