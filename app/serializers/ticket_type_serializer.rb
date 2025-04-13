class TicketTypeSerializer < ActiveModel::Serializer
  attributes :id, :name, :price, :quantity

  belongs_to :event
end
