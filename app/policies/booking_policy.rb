class BookingPolicy < ApplicationPolicy
  def index?
    user.role == "customer"
  end

  def create?
    index?
  end
end
