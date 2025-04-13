class EventsController < ApplicationController
  before_action :authorize_request
  before_action :set_event, only: [ :update, :destroy ]

  def index
    @events = Event.page(params[:page]).per(params[:limit] || 10)
    render json: @events, meta: pagination_meta(@events), status: :ok
  end

  def show
    @event = Event.includes(:ticket_types).find(params[:id])
    authorize @event

    render json: @event, status: :ok
  end

  def create
    @event = current_user.events.build(event_params)
    authorize @event

    if @event.save
      render json: @event, status: :created
    else
      render json: @event.errors, status: :unprocessable_entity
    end
  end

  def update
    authorize @event

    if @event.update(event_params)
      render json: @event, status: :ok
    else
      render json: @event.errors, status: :unprocessable_entity
    end
  end

  def destroy
    authorize @event
    @event.destroy
    head :no_content
  end

  private

  def set_event
    @event = Event.find(params[:id])
  end

  def event_params
    params.require(:event).permit(:name, :location, :date)
  end
end
