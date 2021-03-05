require 'rails_helper'

RSpec.describe Flight, type: :model do
  describe 'relationships' do
    it { should have_many :bookings }
    it { should have_many(:passengers).through(:bookings) }
  end

  describe 'class methods' do
    describe '::all_departure_city_alpha_sort' do
      it 'shows all flights sorted alphabetically by departure city' do
        flight_1 = Flight.create!(number: 1, departure_city: 'Denver', arrival_city: 'Reno', date: DateTime.new(2021, 01, 01))
        flight_2 = Flight.create!(number: 2, departure_city: 'Reno', arrival_city: 'Denver', date: DateTime.new(2021, 01, 02))
        flight_3 = Flight.create!(number: 3, departure_city: 'Atlanta', arrival_city: 'Dallas', date: DateTime.new(2021, 01, 01))

        expect(Flight.all_departure_city_alpha_sort).to eq([flight_3, flight_1, flight_2])
      end
    end
  end
end
