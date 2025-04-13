class EventPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    true
  end

  def create?
    user.role == "organizer"
  end

  def update?
    user.role == "organizer" && record.user_id == user.id
  end

  def destory?
    update?
  end
end
