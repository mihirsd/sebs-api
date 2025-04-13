class BookingSerializer < ActiveModel::Serializer
  attributes :id, :quantity

  belongs_to :ticket_type
end
