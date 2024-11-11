class OrdersController < ApplicationController
  def new
    @order = Order.new
    @order_list = Portion.where(id: session[:order_list])
    @products = @order_list.map {|portion| portion.product}
    # calcular preço/alterar atributo preço para integer
  end
end