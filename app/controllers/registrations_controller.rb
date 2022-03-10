class RegistrationsController < Devise::RegistrationsController
  respond_to :json
  protect_from_forgery with: :null_session

  private

  def respond_with(resource, _opts = {})
    resource.persisted? ? register_success : register_failed
  end

  def register_success
    render json: { message: 'Signed up.' }
  end

  def register_failed
    render json: { message: "Signed up failure."}
  end

end
