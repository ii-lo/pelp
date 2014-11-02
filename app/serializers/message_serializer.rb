class MessageSerializer < ActiveModel::Serializer
  attributes :title, :body, :created_at
  has_one :sender, serializer: SenderSerializer
  has_one :receiver, serializer: ReceiverSerializer
end
