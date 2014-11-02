require 'train'

describe Train  do

    let(:train) { Train.new() }
    let(:passenger) { Passenger.new() }
    let(:station) { Station.new}
  

  it "should know its total capacity" do
    train = Train.new(:coaches => 3)
    expect(train.capacity).to be 120
  end

  it "should know if it is full" do 
    station.docks(train, station)
    train.capacity.times { passenger.boards(train, passenger, station) }
    expect(train).to be_full
  end

  it "should not allow a passenger to board if it is full" do
    station.docks(train, station)
    train.capacity.times { passenger.boards(train, passenger, station) }
    expect{passenger.boards(train,passenger, station)}.to raise_error(TrainFull)  
  end

end