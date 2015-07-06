class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
#protect_from_forgery with: :exception


# 以下を追加
  rescue_from CanCan::AccessDenied do |exception|
  redirect_to root_url, :alert => exception.message
  end

protected

def configure_permitted_parameters
 devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:email, :password, :password_confirmation, :role, :name) }
  devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:email, :password, :password_confirmation, :current_password, :role, :name) }
end

end
