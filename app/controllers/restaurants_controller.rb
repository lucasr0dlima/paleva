class RestaurantsController < ApplicationController
  before_action :authenticate_user!
  def new
    @restaurant = Restaurant.new
  end

  def create
    @restaurant = Restaurant.new(params.require(:restaurant).permit(:brand_name, :corporate_name, :cnpj, :address, :phone_number, :address))
    current_user.restaurant = @restaurant
    @restaurant.save
    redirect_to root_path, notice: 'Restaurante criado com sucesso'  
  end
end