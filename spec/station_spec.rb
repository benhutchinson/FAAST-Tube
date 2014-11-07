require 'station'

describe Station do 

  let(:station) { Station.new(:capacity => 500) }
  let(:passenger) { Passenger.new() }
  let(:passenger_no_credit) { Passenger.new(:credit => 1)}
  let(:train) { Train.new }

  def fill_station_with_passengers(station)
    station.capacity.times {station.allow_in(passenger)}
  end

  it "should let passengers with credit touch in and enter the station" do
    expect(station.passengers_in_station.count).to eq 0
    station.allow_in(passenger)
    expect(station.passengers_in_station.count).to eq 1
  end

  it "should not allow a passenger into the station if they do not have credit" do
    expect{station.allow_in(passenger_no_credit)}.to raise_error NoCredit
  end

  it "should let passengers leave the station" do
    station.allow_in(passenger)
    station.release(passenger)
    expect(station.passengers_in_station.count).to eq 0
  end

  it "should know if it is full with passengers" do
    expect(station.passengers_in_station.count).to be 0
    fill_station_with_passengers(station)
    expect(station).to be_full_of_passengers
  end

  it "should not allow a passenger in if it is full" do
    fill_station_with_passengers(station)
    expect{station.allow_in(passenger)}.to raise_error(StationFull)
  end

  it "must be able to recognise that a train has arrived" do
    train.arrives_at_station(train, station)
    expect(station.train_arrived?(train)).to be true
  end

  it "must be able to recognise that a train has left" do
    train.arrives_at_station(train, station)
    expect(station.train_at_station.count).to be 1
    train.departs_from_station(train, station)
    expect(station.train_at_station.count).to be 0
    expect(station.train_departed?(train)).to be true
  end

  it "should know how many trains are in the station" do 
    expect(station.train_at_station.count).to be 0
    train.arrives_at_station(train, station)
    expect(station.train_at_station.count).to be 1
  end

  it "should know when it is full of trains" do
    train.arrives_at_station(train, station)
    station.train_capacity = 1
    expect(station.full_of_trains?).to be true
  end


  # if train wants to arrive, must accept it provided there is space
  # it should know how much space it has for trains

  
end