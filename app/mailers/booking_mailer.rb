class BookingMailer < ApplicationMailer
  default from: "no-reply@example.com"

  def confirmation_email(booking)
    @booking = booking
    @user = booking.user

    # Sending the email
    # mail(
    #   to: @user.email,
    #   subject: "Booking Confirmation for #{@booking.ticket_type.event.name}"
    # ) do |format|
    #   format.html { render "confirmation_email" }
    # end

    Rails.logger.info "Sending confirmation email to #{@user.email} for booking ID: #{@booking.id}"
  end
end
