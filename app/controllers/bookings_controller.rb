class BookingsController < ApplicationController
  def destroy
    booking = Booking.find_by(flight_id: params[:flight_id], passenger_id: params[:passenger_id])

    if booking
      Booking.delete(booking.id)
    else
      flash[:error] = 'Problem deleting booking.'
    end

    redirect_to flight_path(params[:flight_id])
  end
end
