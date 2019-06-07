class HooksController < ApplicationController
  protect_from_forgery except: [:stripe]
  skip_before_action :authenticate_user!

  def stripe
    skip_authorization
    if params['type'] == 'charge.failed'
      charge_failed(params)
    elsif params['type'] == 'charge.succeeded'
      charge_succeeded(params)
    elsif params['type'] == 'customer.subscription.created'
      subscription_created(params)
    end
  end

  private

  def charge_failed(data)
    @user = User.find_by_email(data['data']['object']['billing_details']['name'])
    @user.update(subscriber: false)
  end

  def charge_succeeded(data)
    @user = User.find_by_email(data['data']['object']['billing_details']['name'])
    @user.update(subscriber: true)
  end

  def subscription_created(data)
    @user = User.find_by_stripe_id(data['data']['object']['customer'])
    @user.update(subscriber: true)
    @user.send_subscribe_email
    invoices('cus_FDH2AQTpezfMzz')
  end

  # def invoices(customer)
  #   @customer = Stripe::Customer.retrieve(customer)
  #   binding.pry
  # end
end
