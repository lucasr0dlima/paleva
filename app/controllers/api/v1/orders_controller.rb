class Api::V1::OrdersController < ActionController::API
  def index
    begin
      restaurant = Restaurant.find_by!(code: params[:restaurant_code])
      orders = restaurant.orders
      render status: 200, json: orders.as_json(except: [:created_at, :updated_at])
    rescue
      render status: 404, json: {}
    end
  end

  def pending
    begin
      restaurant = Restaurant.find_by!(code: params[:restaurant_code])
      orders = restaurant.orders.pending
      render status: 200, json: orders.as_json(except: [:created_at, :updated_at])
    rescue
      render status: 404, json: {}
    end
  end

  def preparation
    begin
      restaurant = Restaurant.find_by!(code: params[:restaurant_code])
      orders = restaurant.orders.preparation
      render status: 200, json: orders.as_json(except: [:created_at, :updated_at])
    rescue
      render status: 404, json: {}
    end
  end

  def ready
    begin
      restaurant = Restaurant.find_by!(code: params[:restaurant_code])
      orders = restaurant.orders.ready
      render status: 200, json: orders.as_json(except: [:created_at, :updated_at])
    rescue
      render status: 404, json: {}
    end
  end

  def canceled
    begin
      restaurant = Restaurant.find_by!(code: params[:restaurant_code])
      orders = restaurant.orders.canceled
      render status: 200, json: orders.as_json(except: [:created_at, :updated_at])
    rescue
      render status: 404, json: {}
    end
  end

  def delivered
    begin
      restaurant = Restaurant.find_by!(code: params[:restaurant_code])
      orders = restaurant.orders.delivered
      render status: 200, json: orders.as_json(except: [:created_at, :updated_at])
    rescue
      render status: 404, json: {}
    end
  end

  def show
    begin
      order = Order.find_by!(code: params[:code])
      render status: 200, json: order.as_json(only: [:name, :created_at, :status], include: :order_items)
    rescue
      render status: 404, json: {}
    end
  end
end