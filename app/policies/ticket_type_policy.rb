class TicketTypePolicy < ApplicationPolicy
  def create?
    user.role == "organizer" && record.event.user_id == user.id
  end

  def update?
    create?
  end

  def destroy?
    create?
  end
end
