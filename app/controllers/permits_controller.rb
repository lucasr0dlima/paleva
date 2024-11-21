class PermitsController < ApplicationController
  before_action :must_register_restaurant, :must_be_admin
  def index
    @restaurant = current_user.restaurant

    @permits = @restaurant.permits
  end

  def new
    @permit = Permit.new
    @restaurant = current_user.restaurant
  end

  def create
    @permit =  Permit.new(params.require(:permit).permit(:cpf, :email))

    @restaurant = current_user.restaurant

    @permit.restaurant = @restaurant

    if @permit.save
      redirect_to permits_path, notice: "Permissão cadastrada com sucesso"
    end
  end
end