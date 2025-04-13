class BookingPolicy < ApplicationPolicy
  def create?
    user.role == "customer"
  end

  def index?
    user.role == "customer"
  end
end
