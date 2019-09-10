class BookingPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      # If the booking's user, or the booking's tool's user,
      # is the current user.
      scope.joins(:tool).where(
        'bookings.user_id = ? or tools.user_id = ?',
        user, user
      )
    end
  end

  def create?
    true
  end

  def show?
    user_is_booker_or_tool_owner?
  end

  def update?
    user_is_booker_or_tool_owner?
  end

  def destroy?
    user_is_booker_or_tool_owner?
  end

  def user_is_booker_or_tool_owner?
    record.user == user || record.tool.user == user
  end
end
