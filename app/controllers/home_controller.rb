class HomeController < ApplicationController
  def index
    if session[:order_list]
      @order_list = Portion.where(id: session[:order_list])
    end
  end

  def clear_order
    session.delete :order_list
    redirect_to root_path
  end
end