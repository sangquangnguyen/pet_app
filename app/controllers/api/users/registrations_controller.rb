# frozen_string_literal: true

class Api::Users::RegistrationsController < Devise::RegistrationsController
  skip_before_action :verify_authenticity_token

  def create
    user = User.new(sign_up_params)
    if user.save
      render json: { message: "User created successfully", user: user, token: token }, status: :created
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def sign_up_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
