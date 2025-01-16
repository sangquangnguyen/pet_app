# frozen_string_literal: true

class Api::Users::SessionsController < Devise::SessionsController
  skip_before_action :verify_authenticity_token
  skip_before_action :verify_signed_out_user, only: [:create]

  def create
    user = User.find_by(email: params[:user][:email])
    if user&.valid_password?(params[:user][:password])
      token = encode_jwt(user)
      render json: { message: "Logged in successfully", user: user, token: token }, status: :ok
    else
      render json: { error: "Invalid email or password" }, status: :unauthorized
    end
  end

  def destroy
    sign_out(current_user)
    render json: { message: "Logged out successfully" }, status: :ok
  end

  private

  def encode_jwt(user)
    JWT.encode({ user_id: user.id, exp: 24.hours.from_now.to_i, jti: SecureRandom.uuid }, Rails.application.secret_key_base)
  end
end
