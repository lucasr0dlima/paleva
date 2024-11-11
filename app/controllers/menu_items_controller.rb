class MenuItemsController < ApplicationController
  before_action :must_register_restaurant
  def new
    
    @menu = Menu.find(params[:menu_id])
   
    @menu_item = @menu.menu_items.build
    @products = current_user.products

  end

  def create
    @menu = Menu.find(params[:menu_id])

    @menu_item = @menu.menu_items.build(params.require(:menu_item).permit(:name, :product_id))

    if @menu_item.save 
      redirect_to menu_path(@menu), notice: "Item cadastrado com sucesso"
    else
      flash.now[:alert] = "Erro no cadastro"
    end
  end
end