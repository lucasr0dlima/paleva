class MenuItemsController < ApplicationController
  def new
    
    @menu = Menu.find(params[:menu_id])
   

    @menu_item = @menu.menu_items.build
    @products = current_user.products
  end
end