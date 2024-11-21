class HomeController < ApplicationController
  def index
    if session[:order_list]
      @order_list = []
      session[:order_list].each do |item_id|
        @order_list << Portion.find(item_id)    
      end
    end
  end

  def clear_order
    session.delete :order_list
    redirect_to root_path
  end
end