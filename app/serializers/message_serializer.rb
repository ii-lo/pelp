class MessageSerializer < ActiveModel::Serializer
  attributes :id, :title, :body, :created_at, :flagged, :in_trash
  has_one :sender, serializer: SenderSerializer
  has_many :receivers, serializer: ReceiverSerializer
end
