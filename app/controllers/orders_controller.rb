class OrdersController < ApplicationController
  before_action :set_order

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

  private

  def set_order
    if current_user.pending_order
      @order = current_user.pending_order
    else
      @order = Order.create(user: current_user)
    end
  end
end
