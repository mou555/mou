require 'spec_helper'
require 'reservation_helper'
require 'hotel'

module ReservationHelper 
  def self.clear
    @hotels = []
  end
end

describe ReservationHelper do
  let (:regular_customer) { :regular }
  let (:rewards_customer) { :rewards }

  let (:thursday) { Time.new(2014, 02, 13) }
  let (:input) { {customer_type: customer_type, dates: [thursday] } }

  let(:hotel) do
    Hotel.new.tap do |h|
      h.name = "Hotel #1"
      h.rating = 3
      h.add_price(regular_customer, false, 100)
        .add_price(regular_customer, true, 60)
        .add_price(rewards_customer, false, 150)
        .add_price(rewards_customer, true, 100)
    end
  end

  let(:expensive_hotel) do
    Hotel.new.tap do |h|
      h.name = "Hotel #2"
      h.rating = 3
      h.add_price(regular_customer, false, 200)
        .add_price(regular_customer, true, 160)
        .add_price(rewards_customer, false, 150)
        .add_price(rewards_customer, true, 110)
    end
  end

  before { ReservationHelper.clear }

  it { should respond_to(:find_cheapest_hotel) }
  it { should respond_to(:register_hotel) }

  context '#register_hotel' do
    it 'adds a new hotel' do
      expect {
        ReservationHelper.register_hotel(hotel)
      }.to change { ReservationHelper.send(:hotels).size }.by(1)
    end

    it 'does not add the same hotel twice' do
      ReservationHelper.register_hotel(hotel)
      expect {
        ReservationHelper.register_hotel(hotel)
      }.not_to change { ReservationHelper.send(:hotels).size }
    end
  end

  context '#find_cheapest_hotel' do
    it 'returns a hotel' do
      ReservationHelper.register_hotel(hotel)
      ReservationHelper.find_cheapest_hotel(regular_customer, [thursday]).should be_a(Hotel)
    end

    it 'returns the only hotel' do
      ReservationHelper.register_hotel(expensive_hotel)
      ReservationHelper.find_cheapest_hotel(regular_customer, [thursday]).should == expensive_hotel
    end

    it 'returns the cheapest hotel' do
      ReservationHelper.register_hotel(hotel)
        .register_hotel(expensive_hotel)
      ReservationHelper.find_cheapest_hotel(regular_customer, [thursday]).should == hotel
    end
  end
end
