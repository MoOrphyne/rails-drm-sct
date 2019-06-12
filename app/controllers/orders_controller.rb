class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :create, :payment]

  def index
    @orders = policy_scope(Order)
  end

  def show
    @order = current_user.orders.find_by_status('pending')
    authorize @order
  end

  def create
    authorize @order
    @pack = Pack.find(params[:pack_id])
    OrderItem.create(order: @order, pack: @pack)
    flash[:notice] = "Pack successfully added to your cart"
  end

  def payment
    authorize @order
    if current_user.stripe_id
      customer = Stripe::Customer.retrieve(current_user.stripe_id)
    else
      customer = Stripe::Customer.create(
        source: params[:stripeToken],
        email:  params[:stripeEmail]
      )
    end

      charge = Stripe::Charge.create(
        customer:     customer.id,   # You should store this customer id and re-use it.
        amount:       @order.total,
        description:  "Payment for order #{@order.id}",
        currency:     'EUR'
      )

      @order.update(payment: charge.to_json, status: 'paid')
      create_user_pack(@order)
      redirect_to profile_path

    rescue Stripe::CardError => e
      flash[:alert] = e.message
      redirect_to new_order_payment_path(@order)
  end

  private

  def set_order
    if current_user.pending_order
      @order = current_user.pending_order
    else
      @order = Order.create(user: current_user)
    end
  end

  def create_user_pack(order)
    order.packs.each { |pack| UserPack.create(user: order.user, pack: pack) }
  end
end
