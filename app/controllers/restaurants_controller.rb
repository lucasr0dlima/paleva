class RestaurantsController < ApplicationController
  before_action :authenticate_user!
  def new
    @restaurant = Restaurant.new
  end

  def create
    @restaurant = Restaurant.new(params.require(:restaurant).permit(:brand_name, :corporate_name, :cnpj, :address, :phone_number, :address))

    @restaurant.valid?
    if @restaurant.errors.full_messages == ["Usuário é obrigatório(a)", "E-mail não pode ficar em branco"]
      @restaurant.user = current_user
    end
    
    if @restaurant.save
      redirect_to root_path, notice: 'Restaurante criado com sucesso'  
    else
      flash.now[:alert] = "Informações Incompletas"
      render :new, status: :unprocessable_entity
    end
  end
end