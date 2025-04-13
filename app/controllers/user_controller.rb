class UserController < ApplicationController
  def profile
    render json: @current_user, status: :ok
  end
end
