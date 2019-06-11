class OrderItemsController < ApplicationController
  def destroy
    @order_item = OrderItem.find(params[:id])
    authorize @order_item
    @order = @order_item.order
    @order_item.destroy

    respond_to do |format|
      format.html { redirect_to order_path(@order) }
      format.js
    end
  end
end
