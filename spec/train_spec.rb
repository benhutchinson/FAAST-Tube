require 'train'

describe Train  do

    let(:train) { Train.new() }
    let(:passenger) { Passenger.new() }
    let(:station) { Station.new}
  
  def fill_up_a_train_on_arrival
    train.arrives_at_station(train, station)
    train.capacity.times { passenger.boards(train, station) }
  end

  def let_a_station_be_full_of_trains 
    train.arrives_at_station(train, station)
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
    train.arrives_at_station(train, station)
    expect(station.train_arrived?(train)).to be true
    expect(station.train_at_station.count).to be 1
  end

  it "must be able to depart from a station" do
    train.arrives_at_station(train, station)
    train.departs_from_station(train, station)
    expect(station.train_at_station.count).to be 0
    expect(station.train_departed?(train)).to be true
  end

  it "must not be able to go to a station that is full" do 
    let_a_station_be_full_of_trains
    expect{train.arrives_at_station(train, station)}.to raise_error(StationIsFullOfTrains)
  end

end