require "test_helper"

class BookingTest < ActiveSupport::TestCase
  test "should be valid with valid attributes" do
    ticket_type = ticket_types(:standard)
    ticket_type.bookings.destroy_all

    booking = Booking.new(user: users(:customer), ticket_type: ticket_types(:empty), quantity: 2)
    assert booking.valid?
  end

  test "should not be valid without a user" do
    booking = Booking.new(ticket_type: ticket_types(:standard), quantity: 1)
    assert_not booking.valid?
  end

  test "should not be valid without a ticket_type" do
    booking = Booking.new(user: users(:customer), quantity: 1)
    assert_not booking.valid?
  end

  test "should belong to a user" do
    assert_respond_to bookings(:booking_small), :user
  end

  test "should belong to a ticket_type" do
    assert_respond_to bookings(:booking_small), :ticket_type
  end

  test "should not allow booking more tickets than available" do
    # Booking already exists for 8 tickets via fixture
    overbooking = Booking.new(user: users(:customer), ticket_type: ticket_types(:standard), quantity: 3)
    assert_not overbooking.save
    assert_match (/Insufficent tickets available/), overbooking.errors[:quantity].first
  end

  test "should allow booking within available ticket limit" do
    booking = Booking.new(user: users(:customer), ticket_type: ticket_types(:empty), quantity: 5)
    assert booking.save
  end
end
