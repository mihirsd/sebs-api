class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :ticket_type

  validate :check_ticket_availability, on: :create

  private

  def check_ticket_availability
    return unless ticket_type && quantity

    ticket_type.with_lock do
      booked = ticket_type.bookings.sum(:quantity)
      available = ticket_type.quantity - booked

      if quantity > available
        errors.add(:quantity, "Insufficent tickets available. Only #{available} tickets left.")
        throw :abort
      end
    end
  end
end
