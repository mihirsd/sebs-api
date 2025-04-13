class TicketTypesController < ApplicationController
  before_action :authorize_request
  before_action :set_event
  before_action :set_ticket_type, only: [ :update, :destroy ]

  def index
    @ticket_types = @event.ticket_types
    render json: @ticket_types, status: :ok
  end

  def create
    @ticket_type = @event.ticket_types.build(ticket_type_params)
    authorize @ticket_type

    if @ticket_type.save
      render json: @ticket_type, status: :created
    else
      render json: @ticket_type.errors, status: :unprocessable_entity
    end
  end

  def update
    authorize @ticket_type

    if @ticket_type.update(ticket_type_params)
      render json: @ticket_type, status: :ok
    else
      render json: @ticket_type.errors, status: :unprocessable_entity
    end
  end

  def destroy
    authorize @ticket_type
    @ticket_type.destroy
    head :no_content
  end

  private

  def set_event
    @event = Event.find(params[:event_id])
  end

  def ticket_type_params
    params.require(:ticket_type).permit(:name, :price, :quantity)
  end
end
