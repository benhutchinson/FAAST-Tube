require 'train'

describe Train  do

    let(:train) { Train.new() }
    let(:passenger) { Passenger.new() }
  

  it "should know its total capacity" do
    train = Train.new(:coaches => 3)
    expect(train.capacity).to be 120
  end

  it "should know if it is full" do 
    train.capacity.times { passenger.boards(train, passenger) }
    expect(train).to be_full
  end

  it "should not allow a passenger to board if it is full" do
    train.capacity.times { passenger.boards(train, passenger) }
    expect{passenger.boards(train,passenger)}.to raise_error(TrainFull)  
  end

end