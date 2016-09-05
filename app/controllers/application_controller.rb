class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_locale

  def verify_admin
    redirect_to root_path unless current_user.role == Settings.role[:admin]
  end

  def after_sign_in_path_for resource
    if resource.is_a? User
      if resource.role == Settings.role[:admin]
        admin_root_path
      else
        root_path
      end
    else
      redirect_to new_user_session_path
    end
  end

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) do |user_params|
      user_params.permit :name, :email, :password,
        :password_confirmation
    end
    devise_parameter_sanitizer.permit(:account_update) do |user_params|
      user_params.permit :name, :email, :password,
        :password_confirmation, :current_password
    end
  end

  private
  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end
end
