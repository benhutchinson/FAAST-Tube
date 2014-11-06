require 'train'

describe Train  do

    let(:train) { Train.new() }
    let(:passenger) { Passenger.new() }
    let(:station) { Station.new}
  
  def fill_up_a_train_on_arrival
    station.docks(train, station)
    train.capacity.times { passenger.boards(train, passenger, station) }
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
   expect{passenger.boards(train,passenger, station)}.to raise_error(TrainFull)  
  end


end