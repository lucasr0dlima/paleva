class BeveragesController < ApplicationController
  before_action :must_register_restaurant, :must_be_admin
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
    @beverage = Beverage.find(params[:id])
  end

  def update
    @beverage = Beverage.find(params[:id])

    if @beverage.update(params.require(:beverage).permit(:name, :description, :image, :calories, :alcohol, :status))
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

  def disable
    @beverage = Beverage.find(params[:id])
    @beverage.inactive!
    redirect_to beverages_path
  end

  def enable
    @beverage = Beverage.find(params[:id])
    @beverage.active!
    redirect_to beverages_path
  end

  def show
    @beverage = Beverage.find(params[:id])
  end
end