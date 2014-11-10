require 'passenger'
require 'exceptions'

describe "A Passenger" do
  
  let (:passenger) { Passenger.new } 
  let (:train) { Train.new() }
  let (:train_with_passengers) { double :train, :full? => true }
  let (:station) { Station.new() }
  let (:station2) { Station.new() }
  let (:station_full_of_passengers) {double :station, :full_of_passengers? => true, :full_of_trains? => false}


  def let_a_passenger_enter_the_station
    station.allow_in(passenger)
  end

  it "should start out with sufficent credit" do 
    expect(passenger).to have_credit
  end

  it "should only be able to be in one station at a time" do 
    station.allow_in(passenger)
    expect{station2.allow_in(passenger)}.to raise_error(PassengerInAnotherStationAlready)
  end

  it "should only be able to board a train if they are in the station" do 
    train.arrives_at_station(station)
    expect{passenger.boards(train, station)}.to raise_error(PassengerNotInStationYet)
  end


  context "When A Train Has Arrived" do

    before :each do 

    def let_train_arrive_in_the_station_and_passenger_board
      train.arrives_at_station(station)
      let_a_passenger_enter_the_station
      passenger.boards(train, station)
    end

    let_train_arrive_in_the_station_and_passenger_board

    end

    it "should be able to board a train" do
      expect(train.passengers_in_train.count).to be 1
    end

    it "should be able to get off a train" do
      passenger.alights(train, station)
      expect(train.passengers_in_train.count).to be 0
    end

  end


  context "When It Has Touched In & Entered A Station" do

    before :each do 

      let_a_passenger_enter_the_station

    end

    it "should only be able to board a train that has arrived at a station" do
      !station.train_arrived?(train)
      expect{passenger.boards(train, station)}.to raise_error(TrainNotInStation)
    end

    it "should only be able to get off a train that has arrived at a station" do
      !station.train_arrived?(train)
      expect{passenger.alights(train, station)}.to raise_error(TrainNotInStation)
    end

  end

end