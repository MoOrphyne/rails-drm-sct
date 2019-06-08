class SubscriptionPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def sub?
    true
  end

  def new_sub?
    User.where(subscriber: true).count < 500
  end

  def cancel_sub?
    true
  end

  def unsubscribe?
    user.subscriber
  end
end
