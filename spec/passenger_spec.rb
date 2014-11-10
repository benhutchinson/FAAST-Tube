require 'passenger'
require 'exceptions'

describe Passenger  do
  
  let (:passenger) { Passenger.new } 
  let (:train) { Train.new() }
  let(:train_with_passengers) { double :train, :full? => true }
  let (:station) { Station.new() }
  let (:station2) { Station.new() }
  let (:station_full_of_passengers) {double :station, :full_of_passengers? => true, :full_of_trains? => false}

  def let_a_passenger_enter_the_station
    station.allow_in(passenger)
  end

  def let_train_arrive_in_the_station_and_passenger_board
    train.arrives_at_station(station)
    let_a_passenger_enter_the_station
    passenger.boards(train, station)
  end

  it "should start out with sufficent credit" do 
    expect(passenger).to have_credit
  end

  it "should be able to board a train" do
    let_train_arrive_in_the_station_and_passenger_board
    expect(train.passengers_in_train.count).to be 1
  end

  it "should only be able to board a train if they are in the station" do 
    train.arrives_at_station(station)
    expect{passenger.boards(train, station)}.to raise_error(PassengerNotInStationYet)
  end

  it "should be able to get off a train" do
    let_train_arrive_in_the_station_and_passenger_board
    passenger.alights(train, station)
    expect(train.passengers_in_train.count).to be 0
  end

  it "should only be able to board a train that has arrived at a station" do
    let_a_passenger_enter_the_station
    !station.train_arrived?(train)
    expect{passenger.boards(train, station)}.to raise_error(TrainNotInStation)
  end

  it "should only be able to get off a train that has arrived at a station" do
    let_a_passenger_enter_the_station
    !station.train_arrived?(train)
    expect{passenger.alights(train, station)}.to raise_error(TrainNotInStation)
  end

  it "should only be able to be in one station at a time" do 
    station.allow_in(passenger)
    expect{station2.allow_in(passenger)}.to raise_error(PassengerInAnotherStationAlready)
  end

end