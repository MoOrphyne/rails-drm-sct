class ReviewPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def new?
    user.got_it?(record.pack)
  end

  def create?
    new?
  end

  def destroy?
    user.admin
  end
end
