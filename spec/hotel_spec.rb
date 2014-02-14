require 'spec_helper'
require 'hotel'

describe Hotel do
  it { should respond_to(:name) }
  it { should respond_to(:rating) }
  it { should respond_to(:price) }
  it { should respond_to(:add_price) }

  let (:hotel) { Hotel.new }

  let (:rewards_customer) { :rewards }
  let (:regular_customer) { :rewards }

  let (:regular_week_value) { 100 }
  let (:regular_weekend_value) { 60 }

  let (:rewards_week_value) { 100 }
  let (:rewards_weekend_value) { 60 }

  let (:monday) { Time.new(2014, 02, 10) }
  let (:sunday) { Time.new(2014, 02, 9) }

  before(:all) do
    hotel.add_price(rewards_customer, true, rewards_weekend_value)
      .add_price(rewards_customer, false, regular_week_value)
      .add_price(regular_customer, true, regular_weekend_value)
      .add_price(regular_customer, false, regular_week_value)
  end

  context '#add_price' do
    it 'adds a price' do
      h = Hotel.new
      expect {
        h.add_price(regular_customer, true, regular_weekend_value)
      }.to change { h.send(:prices).size }.by(1)

      expect {
        h.add_price(regular_customer, false, regular_week_value)
      }.to change { h.send(:prices)[regular_customer].size }.by(1)
    end

    it 'updates a price' do
      h = Hotel.new
      h.add_price(regular_customer, true, regular_weekend_value)

      new_value = 132

      expect {
        h.add_price(regular_customer, true, new_value)
      }.to_not change { h.send(:prices).size }

      h.price(regular_customer, sunday).should == new_value
    end
  end

  context '#price' do
    it 'finds regular week price' do
      hotel.price(regular_customer, monday).should == regular_week_value
    end

    it 'finds regular weekend price' do
      hotel.price(regular_customer, sunday).should == regular_weekend_value
    end

    it 'finds rewards weekend price' do
      hotel.price(rewards_customer, monday).should == rewards_week_value
    end

    it 'finds rewards weekend price' do
      hotel.price(rewards_customer, sunday).should == rewards_weekend_value
    end
  end
end
