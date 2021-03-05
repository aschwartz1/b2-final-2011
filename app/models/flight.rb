class Flight < ApplicationRecord
  has_many :bookings
  has_many :passengers, through: :bookings

  def self.all_departure_city_alpha_sort
    order(:departure_city)
  end

  def adult_passengers
    passengers
      .where('age >= ?', 18)
      .order(:name)
  end

  def adult_passengers_average_age
    return 0 if adult_passengers.count == 0

    res = passengers
      .select('avg(age) as average_adult_age')
      .where('age >= ?', 18)
      .group(:flight_id)
      .reorder(nil) # AR was adding a stupid order by clause (prob from the passengers association) that didn't need to exist, and that broke the query
      .first
      .average_adult_age
  end
end
