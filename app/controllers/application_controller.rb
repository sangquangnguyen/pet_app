class ApplicationController < ActionController::Base
  def authenticate_user!
    token = request.headers['Authorization']&.split(' ')&.last
    if token.present?
      begin
        decoded_token = JWT.decode(token, Rails.application.secret_key_base, true, { algorithm: 'HS256' })
        user_id = decoded_token.first['user_id']
        @current_user = User.find(user_id)
      rescue JWT::DecodeError
        render json: { error: 'Unauthorized' }, status: :unauthorized
      end
    else
      render json: { error: 'Unauthorized' };
    end
  end
end