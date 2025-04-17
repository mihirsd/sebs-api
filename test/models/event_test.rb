require "test_helper"

class EventTest < ActiveSupport::TestCase
  test "should be valid with valid attributes" do
    event = Event.new(user: users(:organizer))
    assert event.valid?
  end

  test "should not be valid without a user" do
    event = Event.new
    assert_not event.valid?
  end

  test "should belong to a user" do
    assert_respond_to events(:event_one), :user
  end

  test "should have many ticket_types" do
    assert_respond_to events(:event_one), :ticket_types
  end

  test "destroying event should destroy associated ticket_types" do
    event = events(:event_one)
    ticket_types(:standard) # ensure it's loaded

    assert_difference "TicketType.count", -1 do
      event.destroy
    end
  end
end
