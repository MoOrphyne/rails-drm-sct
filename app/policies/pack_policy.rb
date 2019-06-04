class PackPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all if user.admin
    end
  end

  def new?
    user.admin
  end

  def create?
    new?
  end

  def show?
    true
  end

  def download?
    user.packs.find(record.id)
  end

  def shop?
    true
  end
end
