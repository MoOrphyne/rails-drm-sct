class SubscriptionsController < ApplicationController
  def new
  end

  def create
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
    current_user.subscriber = true
    current_user.save
    redirect_to root_path

  rescue Stripe::CardError => e
    flash[:alert] = e.message
    redirect_to new_order_payment_path(@order)
  end
end
