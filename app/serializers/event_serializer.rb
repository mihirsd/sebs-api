class EventSerializer < ActiveModel::Serializer
  attributes :id, :name, :location, :date

  has_many :ticket_types
end
