class RegistrationsController < Devise::RegistrationsController
  before_action :configure_account_update_params, only: [:update]
  private

  def after_update_path_for(resource)
    root_path
  end

  def after_sign_up_path_for(resource)
    root_path
  end

  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: [:username])
  end
end
