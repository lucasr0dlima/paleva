class PortionsController < ApplicationController
  before_action :must_register_restaurant, :must_be_admin
  def new
    @product = Product.find(params[:product_id])

    @portion = @product.portions.build
  end

  def create
    if params[:dish_id]
      @product = Product.find(params[:dish_id])
    elsif params[:beverage_id]
      @product = Product.find(params[:beverage_id])
    end

    @portion = @product.portions.build(params.require(:portion).permit(:description, :price))

    if @portion.save 
      redirect_to product_portions_path(@product.id), notice: "Porção adicionada com sucesso"
    else
      flash.now[:alert] = "Falha na Adição"
      render :new
    end
  end

  def index
    if params[:dish_id]
      @product = Product.find(params[:dish_id])
    elsif params[:beverage_id]
      @product = Product.find(params[:beverage_id])
    elsif params[:product_id]
      @product = Product.find(params[:product_id])
    end

    @portions = @product.portions
  end

  def edit
    @portion = Portion.find(params[:id])
  end

  def update
    @portion = Portion.find(params[:id])

    if @portion.update(params.require(:portion).permit(:price))
      redirect_to product_portions_path(@portion.product.id), notice: "Porção atualizada com sucesso"
    end
  end

  def order
    session[:order_list] ||= []

    @portion = Portion.find(params[:id])

    session[:order_list] << @portion.id

    redirect_to root_path
  end
end