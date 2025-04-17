require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "should not save user without email" do
    user = User.new(password: "password", role: "customer")
    assert_not user.save, "Saved the user without an email"
  end

  test "should not save user with non-unique email" do
    original = users(:customer)
    duplicate = User.new(
      email: original.email,
      password: "password",
      password_confirmation: "password",
      role: "customer"
    )
    assert_not duplicate.save, "Saved user with duplicate email"
  end

  test "should save user with valid attributes" do
    user = User.new(
      email: "new@example.com",
      password: "password",
      password_confirmation: "password",
      role: "organizer"
    )
    assert user.save
  end

  test "should not save user with invalid role" do
    user = User.new(
      email: "badrole@example.com",
      password: "password",
      role: "admin"
    )
    assert_not user.save
  end

  test "organizer? returns true for organizer role" do
    assert users(:organizer).organizer?
  end

  test "customer? returns true for customer role" do
    assert users(:customer).customer?
  end

  test "should generate jti before creation" do
    user = User.create!(
      email: "new@example.com",
      password: "password",
      role: "customer"
    )
    assert_not_nil user.jti
  end

  test "invalidate_jti! should change jti" do
    user = users(:customer)
    old_jti = user.jti
    user.invalidate_jti!
    assert_not_equal old_jti, user.jti
  end

  test "should have many events" do
    assert_respond_to users(:organizer), :events
  end

  test "should have many bookings" do
    assert_respond_to users(:customer), :bookings
  end
end
