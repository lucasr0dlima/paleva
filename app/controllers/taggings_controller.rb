class TaggingsController < ApplicationController
  before_action :must_register_restaurant
  def new
    if params[:dish_id]
      @product = Product.find(params[:dish_id])
    elsif params[:beverage_id]
      @product = Product.find(params[:beverage_id])
    end

    @tagging = @product.taggings.build
    @tags = Tag.all
  end

  def create
    if params[:dish_id]
      @product = Product.find(params[:dish_id])
    elsif params[:beverage_id]
      @product = Product.find(params[:beverage_id])
    end

    @tagging = @product.taggings.build(params.require(:tagging).permit(:tag_id))

    if @tagging.save 
      if @product.type == "Beverage"
        redirect_to beverages_path, notice: "Tag adicionada"
      elsif @product.type == "Dish"
        redirect_to dishes_path, notice: "Tag adicionada"
      end
    end
  end
end