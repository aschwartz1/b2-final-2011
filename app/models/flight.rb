class Flight < ApplicationRecord
  has_many :bookings
  has_many :passengers, through: :bookings
end
