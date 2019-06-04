class SubscriptionsController < ApplicationController
  def new
    authorize :subscription, :new?
  end

  def create
    if User.where(subscriber: true).count < 500
      subscribe
    else
      redirect_to root_path
    end
    authorize :subscription, :create?
  end

  def unsubscribe
    @subscriber = Stripe::Customer.retrieve(current_user.stripe_id)
    @subscription = @subscriber.subscriptions.data[0].id

    Stripe::Subscription.update(
      @subscription,
      {
        cancel_at_period_end: true,
      }
    )
    authorize :subscription, :unsubscribe?
  end

  private

  def subscribe
    if current_user.stripe_id
      customer = Stripe::Customer.retrieve(current_user.stripe_id)
    else
      customer = Stripe::Customer.create(
        source: params[:stripeToken],
        email:  params[:stripeEmail]
      )
      current_user.stripe_id = customer.id
      current_user.save
    end

    subscription = Stripe::Subscription.create({
      customer: customer.id,
      plan: 'plan_EopqywkUr0PMSQ',
    })
    # @order.update(payment: charge.to_json, state: 'paid')
    current_user.to_subscriber
    redirect_to profile_path

  rescue Stripe::CardError => e
    flash[:alert] = e.message
    redirect_to new_order_payment_path(@order)
  end
end
