require "test_helper"

class TicketTypeTest < ActiveSupport::TestCase
  test "should be valid with valid attributes" do
    ticket_type = TicketType.new(
      event: events(:event_one),
      name: "VIP",
      price: 100,
      quantity: 5
    )
    assert ticket_type.valid?
  end

  test "should not be valid without an event" do
    ticket_type = TicketType.new(name: "Solo", price: 20, quantity: 10)
    assert_not ticket_type.valid?
  end

  test "should belong to an event" do
    assert_respond_to ticket_types(:standard), :event
  end

  test "should have many bookings" do
    assert_respond_to ticket_types(:standard), :bookings
  end
end
