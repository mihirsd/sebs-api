class EventPolicy < ApplicationPolicy
  def create?
    user.role == "organizer"
  end

  def update?
    user.role == "organizer" && record.user_id == user.id
  end

  def destory?
    update?
  end

  def show?
    true
  end

  def index?
    true
  end
end
