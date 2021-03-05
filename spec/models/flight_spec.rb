require 'rails_helper'

RSpec.describe Flight, type: :model do
  describe 'relationships' do
    it { should have_many :bookings }
    it { should have_many(:passengers).through(:bookings) }
  end

  describe 'class methods' do
    describe '::all_departure_city_alpha_sort' do
      it 'shows all flights sorted alphabetically by departure city' do
        flight_1 = Flight.create!(number: 1, departure_city: 'Denver', arrival_city: 'Reno', departing_at: DateTime.new(2021, 01, 01))
        flight_2 = Flight.create!(number: 2, departure_city: 'Reno', arrival_city: 'Denver', departing_at: DateTime.new(2021, 01, 02))
        flight_3 = Flight.create!(number: 3, departure_city: 'Atlanta', arrival_city: 'Dallas', departing_at: DateTime.new(2021, 01, 01))

        expect(Flight.all_departure_city_alpha_sort).to eq([flight_3, flight_1, flight_2])
      end
    end
  end

  describe 'instance methods' do
    describe '#adult_passengers' do
      it 'returns passengers who are >= 18 years old (sorted alphabetically by name' do
        flight = Flight.create!(number: 1, departure_city: 'Denver', arrival_city: 'Reno', departing_at: DateTime.new(2021, 01, 01))
        bronson = flight.passengers.create!(name: 'Bronson', age: 18)
        bob = flight.passengers.create!(name: 'Bob', age: 42)
        elsie = flight.passengers.create!(name: 'Elsie', age: 4)

        expect(flight.adult_passengers).to eq([bob, bronson])
      end

      it 'returns empty array if their are no passengers at all' do
        flight = Flight.create!(number: 1, departure_city: 'Denver', arrival_city: 'Reno', departing_at: DateTime.new(2021, 01, 01))
        expect(flight.adult_passengers).to eq([])
      end

      it 'returns empty array if their are no adult passengers' do
        # But why are there no adults on this flight is the real question
        flight = Flight.create!(number: 1, departure_city: 'Denver', arrival_city: 'Reno', departing_at: DateTime.new(2021, 01, 01))
        elsie = flight.passengers.create!(name: 'Elsie', age: 4)
        expect(flight.adult_passengers).to eq([])
      end
    end

    describe '#adult_passengers_average_age' do
      it 'returns adult passenger average age' do
        flight = Flight.create!(number: 1, departure_city: 'Denver', arrival_city: 'Reno', departing_at: DateTime.new(2021, 01, 01))
        bronson = flight.passengers.create!(name: 'Bronson', age: 18)
        bob = flight.passengers.create!(name: 'Bob', age: 42)
        elsie = flight.passengers.create!(name: 'Elsie', age: 4)

        expect(flight.adult_passengers_average_age).to eq(30)
      end

      it 'returns 0 if there are no passengers' do
        flight = Flight.create!(number: 1, departure_city: 'Denver', arrival_city: 'Reno', departing_at: DateTime.new(2021, 01, 01))
        expect(flight.adult_passengers_average_age).to eq(0)
      end

      it 'returns 0 if there are only children' do
        flight = Flight.create!(number: 1, departure_city: 'Denver', arrival_city: 'Reno', departing_at: DateTime.new(2021, 01, 01))
        elsie = flight.passengers.create!(name: 'Elsie', age: 4)
        expect(flight.adult_passengers_average_age).to eq(0)
      end
    end
  end
end
