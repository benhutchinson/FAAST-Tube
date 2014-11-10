require 'station'
require 'exceptions'

describe Station do 

  let(:station) { Station.new(:capacity => 500) }
  let(:small_station) { Station.new(:capacity => 2)}
  let(:passenger) { Passenger.new() }
  let(:passenger2) { Passenger.new() }
  let(:passenger_no_credit) { Passenger.new(:credit => 1)}
  let(:train) { Train.new }

  def fill_station_with_passengers(small_station)
    small_station.allow_in(passenger)
    small_station.allow_in(passenger2)
  end

  def let_a_passenger_with_credit_touch_in
    station.allow_in(passenger)
  end

  it "should let passengers with credit touch in and enter the station" do
    let_a_passenger_with_credit_touch_in
    expect(station.passengers_in_station.count).to eq 1
  end

  it "should not allow a passenger into the station if they do not have credit" do
    expect{station.allow_in(passenger_no_credit)}.to raise_error NoCredit
  end

  it "should know if it is full with passengers" do
    fill_station_with_passengers(small_station)
    expect(small_station).to be_full_of_passengers
  end

  it "should not allow a passenger in if it is full" do
    fill_station_with_passengers(small_station)
    expect{small_station.allow_in(passenger)}.to raise_error(StationFull)
  end

  it "should not allow a passenger to alight a train if full" do 
    fill_station_with_passengers(small_station)
    train.arrives_at_station(small_station)
    expect{passenger.alights(train, small_station)}.to raise_error(StationFull)
  end

  it "should let passengers leave the station" do
    let_a_passenger_with_credit_touch_in
    station.release(passenger)
    expect(station.passengers_in_station.count).to eq 0
  end

  it "should not allow a passenger to leave if not in the station" do
    let_a_passenger_with_credit_touch_in
    train.arrives_at_station(station)
    passenger.boards(train, station)
    expect{station.release(passenger)}.to raise_error PassengerNotInStation
  end

  it "must be able to recognise that a train has arrived" do
    train.arrives_at_station(station)
    expect(station.train_arrived?(train)).to be true
  end

  it "must be able to recognise that a train has left" do
    train.arrives_at_station(station)
    train.departs_from_station(station)
    expect(station.train_departed?(train)).to be true
  end

  it "should know when it is full of trains" do
    train.arrives_at_station(station)
    station.train_capacity = 1
    expect(station.full_of_trains?).to be true
  end
  
end