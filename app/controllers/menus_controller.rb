class MenusController < ApplicationController
  before_action :must_register_restaurant
  def new
    @menu = Menu.new
  end

  def create
    @menu = Menu.new(params.require(:menu).permit(:name))

    @menu.restaurant = current_user.restaurant

    if @menu.save
      redirect_to root_path, notice: "Cardápio criado com sucesso"
    end
  end

  def show
    if session[:order_list]
      @order_list = Portion.where(id: session[:order_list])
    end

    @menu = Menu.find(params[:id])
    @dishes = current_user.dishes
    @beverages = current_user.beverages
  end
end