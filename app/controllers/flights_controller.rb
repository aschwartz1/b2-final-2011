class FlightsController < ApplicationController
  def index
    @flights = Flight.all_departure_city_alpha_sort
  end
end
