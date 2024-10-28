class BeveragesController < ApplicationController
  before_action :must_register_restaurant
  def index
    @beverages = current_user.beverages
  end

  def new
    @beverage = Beverage.new
  end
  
  def create
    @beverage = Beverage.new(params.require(:beverage).permit(:name, :description, :calories, :image, :alcohol))
    @beverage.user = current_user
    @beverage.restaurant = current_user.restaurant

    if @beverage.save 
      redirect_to beverages_path, notice: "Bebida adicionada com sucesso"
    else
      flash.now[:notice] = "Falha no Cadastro"
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @beverage= Beverage.find(params[:id])
  end

  def update
    @beverage = Beverage.find(params[:id])

    if @beverage.update(params.require(:beverage).permit(:name, :description, :image, :calories, :alcohol))
      redirect_to beverages_path, notice: "Bebida editado com sucesso"
    else
      flash.now[:alert] = "Informações Incompletas"
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @beverage = Beverage.find(params[:id])
    @beverage.destroy

    redirect_to beverages_path, alert: "Bebida Removido"
  end
end