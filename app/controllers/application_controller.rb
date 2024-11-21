class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :last_name, :cpf])
  end

  def must_register_restaurant
    if user_signed_in? && !current_user.restaurant.present?
      redirect_to root_path
    end
  end

  def must_be_admin
    if user_signed_in? && current_user.role == "regular"
      redirect_to root_path, alert: "Página reservada para adiminstradores"
    end
  end
end
