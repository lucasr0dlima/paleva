class OrdersController < ApplicationController
  def new
    @order = Order.new
    @order_list = []

    if session[:order_list]
      session[:order_list].each do |item_id|
        @order_list << Portion.find(item_id)    
      end
    end
    @total_value = 0
    @order_list.each do |portion|
      @total_value += portion.dollars
    end
  end

  def create
    @order = Order.new(params.require(:order).permit(:name, :email, :phone_number, :cpf, :note))
    @order_list = []
    session[:order_list].each do |item_id|
      @order_list << Portion.find(item_id)    
    end

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

  def edit
    @order = Order.find(params[:id])
  end

  def update
    @order = Order.find(params[:id])

    if @order.update(params.require(:order).permit(:status))
      redirect_to order_path(@order)
    end
  end

end