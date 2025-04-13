class ApplicationController < ActionController::API
  before_action :authorize_request

  def authorize_request
    header = request.headers["Authorization"]
    token = header.split(" ").last if header
    decoded = JsonWebToken.decode(token)

    @current_user = User.find_by(email: decoded[:user_email]) if decoded

    if @current_user.blank? || @current_user.jti != decoded[:jti]
      render json: { error: "Not Authorized" }, status: :unauthorized
    end
  end
end
