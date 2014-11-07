require 'passenger'

describe Passenger  do
  
  let (:passenger) { Passenger.new } 
  let (:train) { Train.new() }
  let (:station) { Station.new() }

  def let_train_arrive_in_the_station_and_passenger_board
    train.arrives_at_station(train, station)
    passenger.boards(train, station)
  end

  it "should start out with sufficent credit" do 
    expect(passenger).to have_credit
  end

  it "should be able to board a train" do
    let_train_arrive_in_the_station_and_passenger_board
    expect(train.passengers_in_train.count).to be 1
  end

  it "should be able to get off a train" do
    let_train_arrive_in_the_station_and_passenger_board
    expect(train.passengers_in_train.count).to be 1
    passenger.alights(train, station)
    expect(train.passengers_in_train.count).to be 0
  end

  it "should only be able to board a train that has arrived at a station" do
    !station.train_arrived?(train)
    expect {passenger.boards(train, station)}.to raise_error(TrainNotInStation)
  end

  it "should only be able to get off a train that has arrived at a station" do
    !station.train_arrived?(train)
    expect{passenger.alights(train, station)}.to raise_error(TrainNotInStation)
  end

end