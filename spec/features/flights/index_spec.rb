require 'rails_helper'

RSpec.describe 'Flights index page' do
  describe 'as a visitor' do
    it 'shows high-level info for each flight in the system' do
      flight_1 = Flight.create!(number: 1, departure_city: 'Denver', arrival_city: 'Reno', departing_at: DateTime.new(2021, 01, 01))
      flight_2 = Flight.create!(number: 2, departure_city: 'Reno', arrival_city: 'Denver', departing_at: DateTime.new(2021, 01, 02))
      visit flights_path

      within('#flights') do
        within("#flight-#{flight_1.id}") do
          expect(page).to have_content(flight_1.number)
          expect(page).to have_content(flight_1.departure_city)
          expect(page).to have_content(flight_1.arrival_city)
        end

        within("#flight-#{flight_2.id}") do
          expect(page).to have_content(flight_2.number)
          expect(page).to have_content(flight_2.departure_city)
          expect(page).to have_content(flight_2.arrival_city)
        end
      end
    end

    it 'flights are listed in alphabetical order by departure city' do
      flight_1 = Flight.create!(number: 1, departure_city: 'Denver', arrival_city: 'Reno', departing_at: DateTime.new(2021, 01, 01))
      flight_2 = Flight.create!(number: 2, departure_city: 'Reno', arrival_city: 'Denver', departing_at: DateTime.new(2021, 01, 02))
      flight_3 = Flight.create!(number: 3, departure_city: 'Atlanta', arrival_city: 'Dallas', departing_at: DateTime.new(2021, 01, 01))
      visit flights_path

      within('#flights') do
        actual_city_line = page.all('.departure-city').map(&:text)
        expected_city_order = [flight_3.departure_city, flight_1.departure_city, flight_2.departure_city]

        expect(actual_city_line.size).to eq(3)
        actual_city_line.each_with_index do |text, i|
          expect(actual_city_line[i]).to include(expected_city_order[i])
        end
      end
    end
  end
end
