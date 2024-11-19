class OrdersController < ApplicationController
  def new
    @order = Order.new
    @order_list = Portion.where(id: session[:order_list])
  end

  def create
    @order = Order.new(params.require(:order).permit(:name, :email, :phone_number, :cpf))
    @order_list = Portion.where(id: session[:order_list])

    @order_list.each do |portion|
      @order.order_items.build(portion_id: portion.id)
    end

    @order.restaurant = current_user.restaurant

    if @order.save
      session.delete :order_list
      redirect_to root_path, notice: "Pedido feito com sucesso"
    end
  end

  def index
    @orders = current_user.restaurant.orders
  end

  def show
    @order = Order.find(params[:id])

    @portions = @order.portions
  end
end