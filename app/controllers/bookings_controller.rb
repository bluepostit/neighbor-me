class BookingsController < ApplicationController
  before_action :set_booking, only: %i[show edit update destroy]
  before_action :set_tool, only: %i[new create]

  def index
    @bookings = policy_scope(Booking)
  end

  def show
    redirect_to bookings_path if @booking.nil?
  end

  def new
    @booking = Booking.new
    authorize @booking
  end

  def create
    @booking = Booking.new(booking_params)
    @booking.user = current_user
    @booking.tool = @tool
    authorize @booking
    if @booking.save
      flash.notice = "New booking created."
      redirect_to booking_path @booking
    else
      p @booking.errors
      flash.alert = "The information you entered is incomplete."
      render :new
    end
  end

  def edit
  end

  def update
    if @booking.update(booking_params)
      flash.notice = "Booking has been updated."
      redirect_to booking_path @booking
    else
      p @booking.errors
      flash.alert = "The information you entered is incomplete."
      render :edit
    end
  end

  def destroy
    @booking.destroy
    flash.notice = "Booking has been deleted."
    redirect_to bookings_path
  end

  protected

  def set_booking
    @booking = Booking.find(params[:id])
    authorize @booking
  rescue ActiveRecord::RecordNotFound
    flash.alert = "We couldn't find that booking."
    redirect_to bookings_path
  rescue Pundit::NotAuthorizedError
    flash.alert = "You are not allowed to do this action."
    redirect_to bookings_path
  end

  def set_tool
    @tool = Tool.find(params[:tool_id])
  rescue ActiveRecord::RecordNotFound
    flash.alert = "We couldn't find that tool."
    redirect_to bookings_path
  end

  def booking_params
    fields = %i[collect_time return_time collected_time returned_time]
    params.require(:booking).permit(fields)
  end
end
