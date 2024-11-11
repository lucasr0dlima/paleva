class MenusController < ApplicationController
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
    @menu = Menu.find(params[:id])
  end
end