require 'train'

describe Train  do

    let(:train) { Train.new() }
    let(:passenger) { Passenger.new() }
    let(:station) { Station.new}
  
  def fill_up_a_train_on_arrival
    train.arrives_at_station(station)
    train.capacity.times { passenger.boards(train, station) }
  end

  def create_a_station_that_is_full_of_trains 
    train.arrives_at_station(station)
    station.train_capacity = 1
  end

  it "should know its total capacity" do
    train = Train.new(:coaches => 3)
    expect(train.capacity).to be 120
  end

  it "should know if it is full" do 
    fill_up_a_train_on_arrival
    expect(train).to be_full
  end

  it "should not allow a passenger to board if it is full" do
    fill_up_a_train_on_arrival 
    expect{passenger.boards(train, station)}.to raise_error(TrainFull)  
  end

  it "must be able to arrive at a station" do
    train.arrives_at_station(station)
    expect(station.train_arrived?(train)).to be true
  end

  it "must be able to depart from a station" do
    train.arrives_at_station(station)
    train.departs_from_station(station)
    expect(station.train_departed?(train)).to be true
  end

  it "must not be able to go to a station that is full" do 
    create_a_station_that_is_full_of_trains
    expect{train.arrives_at_station(station)}.to raise_error(StationIsFullOfTrains)
  end

end