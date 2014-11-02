class MessageSerializer < ActiveModel::Serializer
  attributes :topic, :body, :created_at
  has_one :sender, serializer: SenderSerializer
  has_one :receiver, serializer: ReceiverSerializer
end
