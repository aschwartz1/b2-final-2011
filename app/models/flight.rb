class Flight < ApplicationRecord
  has_many :bookings
  has_many :passengers, through: :bookings

  def self.all_departure_city_alpha_sort
    order(:departure_city)
  end
end
