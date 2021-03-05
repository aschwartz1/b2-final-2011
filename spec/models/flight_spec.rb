require 'rails_helper'

RSpec.describe Flight, type: :model do
  describe 'relationships' do
    it { should have_many :bookings }
    it { should have_many(:passengers).through(:bookings) }
  end
end
