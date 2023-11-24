class ApplicationController < ActionController::Base
  rescue_from CanCan::AccessDenied do |exception|
    flash[:alert] = "Acceso denegado."
    redirect_to root_url
  end
end
