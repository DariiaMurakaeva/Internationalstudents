class Api::V1::ApplicationController < ActionController::API
    before_action :authenticate_user!
    
    rescue_from JWT::DecodeError, with: :handle_jwt_error
    rescue_from JWT::ExpiredSignature, with: :handle_jwt_error
  
    private
  
    def authenticate_user!
      header = request.headers['Authorization']
      if header.blank?
        render json: { error: 'Authorization header missing' }, status: :unauthorized
        return
      end
  
      token = header.split(' ').last
      payload = JWT.decode(token, Rails.application.credentials.devise_jwt_secret_key!, true, { algorithm: 'HS256' }).first
      @current_user = User.find_by(email: payload['email'])
      
      unless @current_user
        render json: { error: 'User not found' }, status: :unauthorized
      end
    rescue JWT::DecodeError, JWT::ExpiredSignature => e
      render json: { error: "Invalid token: #{e.message}" }, status: :unauthorized
    end
  
    def handle_jwt_error(exception)
      render json: { error: exception.message }, status: :unauthorized
    end
  end