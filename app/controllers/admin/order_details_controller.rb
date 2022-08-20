class Admin::OrderDetailsController < ApplicationController
  def update
    @order = Order.all
    @order_detail = OrderDetail.find(params[:id])
    @order_detail.update(order_detail_params)
    @order = @order_detail.order
    if @order_detail.making_status == "製作中"
      @order.update(status: 2)
      flash[:notice] = "制作ステータスの更新しました。"
      @order.save
    end

    if @order.order_details.count == @order.order_details.where(making_status: 3).count
      @order.update(status: 3)
      flash[:notice] = "制作ステータスの更新しました。"
      @order.save
    end
    redirect_to admin_order_path
  end

  private
  def order_detail_params
    params.require(:order_detail).permit(:order_id, :making_status, :count, :order_id)
  end
end
