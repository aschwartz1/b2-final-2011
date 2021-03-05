require 'rails_helper'

RSpec.describe 'Flights index page' do
  before :each do
    @flight = Flight.create!(number: 1, departure_city: 'Denver', arrival_city: 'Reno', departing_at: DateTime.new(2021, 01, 01, 8, 30))
    @bob = @flight.passengers.create!(name: 'Bob', age: 42)
    @bronson = @flight.passengers.create!(name: 'Bronson', age: 18)
    @elsie = @flight.passengers.create!(name: 'Elsie', age: 4)
  end

  describe 'as a visitor' do
    it 'shows flight info' do
      visit flight_path(@flight)

      within('#info') do
        expect(page).to have_content(@flight.number)
        expect(page).to have_content(@flight.departing_at)
        expect(page).to have_content(@flight.departure_city)
        expect(page).to have_content(@flight.arrival_city)
      end
    end

    it 'shows names of adult passengers' do
      # Adult is >= 18 years old
      visit flight_path(@flight)

      within('#adult-passengers') do
        expect(page).to have_content(@bob.name)
        expect(page).to have_content(@bronson.name)
        expect(page).to_not have_content(@elsie.name)
      end
    end

    it 'shows average age of adult passengers on the flight' do
      visit flight_path(@flight)

      within('#adult-passengers-avg-age') do
        expect(page).to have_content('30')
      end
    end
  end
end
