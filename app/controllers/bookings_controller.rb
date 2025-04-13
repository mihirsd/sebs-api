class BookingsController < ApplicationController
  before_action :authorize_request

  def index
    @bookings = current_user.bookings
                            .includes(ticket_type: :event)
                            .page(params[:page])
                            .per(params[:per_page] || 10)

    render json: @bookings, meta: pagination_meta(@bookings)
  end

  def create
    @booking = current_user.bookings.build(booking_params)
    authorize @booking

    if @booking.save
      render json: @booking, status: :created
    else
      render json: @booking.errors, status: :unprocessable_entity
    end
  end

  private

  def booking_params
    params.require(:booking).permit(:ticket_type_id, :quantity)
  end
end
