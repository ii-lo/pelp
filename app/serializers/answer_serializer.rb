class AnswerSerializer < ActiveModel::Serializer
  attributes :id, :name, :correct, :question_id
end
