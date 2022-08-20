class Admin::OrdersController < ApplicationController
  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_details
    @total = 0
    @order_details.each do |detail|
      @total += detail.price
    end
  end

  def update
    @order = Order.find(params[:id])
    @order.update(order_params)
    redirect_to admin_order_path(@order)
  end

  private
  def order_params
    params.require(:order).permit(:shipping_cost,:total_payment,:name,:payment_method,:address,:postal_code,:status,:making_status)
  end
end
