class DishesController < ApplicationController
  before_action :must_register_restaurant
  def index
    @dishes = current_user.dishes
  end

  def new
    @dish = Dish.new
  end

  def create
    @dish = Dish.new(params.require(:dish).permit(:name, :description, :calories, :image))
    @dish.user = current_user
    @dish.restaurant = current_user.restaurant

    if @dish.save 
      redirect_to dishes_path, notice: "Prato adicionado com sucesso"
    else
      flash.now[:notice] = "Falha no Cadastro"
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @dish = Dish.find(params[:id])
  end

  def update
    @dish = Dish.find(params[:id])

    if @dish.update(params.require(:dish).permit(:name, :description, :image, :calories))
      redirect_to dishes_path, notice: "Prato editado com sucesso"
    else
      flash.now[:alert] = "Informações Incompletas"
      render :edit, status: :unprocessable_entity
    end
  end
end