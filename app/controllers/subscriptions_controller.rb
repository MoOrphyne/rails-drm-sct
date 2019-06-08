class SubscriptionsController < ApplicationController

  def sub
    authorize :subscription, :sub?
    @subscribers = User.where(subscriber: true)
  end

  def cancel_sub
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

  def new_sub
    authorize :subscription, :new_sub?

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
      plan: 'plan_FDFmCLQuY5YY6L',
      billing: 'send_invoice',
      days_until_due: 1,
    })

    redirect_to profile_path

  rescue Stripe::CardError => e
    flash[:alert] = e.message
    redirect_to new_order_payment_path(@order)
  end
end
