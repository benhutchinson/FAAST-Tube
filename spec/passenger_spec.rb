require 'passenger'

describe Passenger  do
  
  let (:passenger) { Passenger.new } 
  let (:train) { Train.new() }
  let (:station) { Station.new() }

  it "should start out with credit" do 
    # start with a bare-bones type feature
    # that we expect to be present
    # let's test this feature
    expect(passenger).to have_credit
  end

  it "should be able to board a train" do
    station.docks(train, station)
    passenger.boards(train, passenger, station)
    expect(train.passengers_in_train_count).to be 1
  end

  it "should be able to get off a train" do
    station.docks(train, station)
    passenger.boards(train, passenger, station)
    expect(train.passengers_in_train_count).to be 1
    passenger.alights(train, passenger, station)
    expect(train.passengers_in_train_count).to be 0
  end

  it "should only be able to get off a train that has arrived at a station" do
    station.docks(train, station)
    station.undocks(train, station)
    expect{ passenger.alights(train, passenger, station) }.to raise_error(TrainNotInStation)
  end

  it "should only be able to board a train that has arrived at a station" do
    station.docks(train, station)
    station.undocks(train, station)
    expect { passenger.boards(train, passenger, station) }.to raise_error(TrainNotInStation)
  end

end