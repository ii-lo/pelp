class MessagesController < ApplicationController
  def index
    @user = current_user
    @view_data = @user.received_messages
    @view_data_json = [SenderSerializer.new(current_user, root: false), ActiveModel::ArraySerializer.new(@view_data, each_serializer: MessageSerializer)].to_json
  end

  def page
    user = current_user
    type = params[:type]
    messages = case type
               when 'sent'
                 params[:sent_page] = params[:page]
                 user.sent_messages.paginate(per_page: 30,
                 page: params[:sent_page])
               else
                 params[:unread_page] = params[:page]
                 user.received_messages.paginate(per_page: 30,
                 page: params[:unread_page])
               end

    respond_to do |format|
      format.json { render json: ActiveModel::ArraySerializer.new(messages, each_serializer: MessageSerializer) }
    end
  end

  def test
    messages = Message.all.includes :sender, :receiver

    respond_to do |format|
      format.json { render json: [SenderSerializer.new(current_user, root: false), ActiveModel::ArraySerializer.new(messages, each_serializer: MessageSerializer)].to_json }
    end
  end
end
