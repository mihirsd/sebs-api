class AuthController < ApplicationController
  skip_before_action :authorize_request, only: [ :login, :register ]

  def register
    user = User.new(user_params)
    if user.save
      token = JsonWebToken.encode(user_email: user.email, jti: user.jti)
      render json: { token:, user: }, status: :created
    else
      render json: { error: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def login
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      token = JsonWebToken.encode(user_email: user.email, jti: user.jti)
      render json: { token:, user: }, status: :ok
    else
      render json: { error: "Invalid email or password" }, status: :unauthorized
    end
  end

  def logout
    @current_user.invalidate_jti!
    render json: { message: "Logged out successfully" }, status: :ok
  end

  private

  def user_params
    params.permit(:name, :email, :password, :password_confirmation, :role)
  end
end
