class DashboardPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def profile?
    true
  end

  def admin?
    user.admin
  end
end
