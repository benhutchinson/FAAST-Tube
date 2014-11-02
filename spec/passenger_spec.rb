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
    passenger.boards(train, passenger)
    expect(train.passengers_in_train_count).to be 1
  end

  it "should be able to get off a train" do
    passenger.boards(train, passenger)
    expect(train.passengers_in_train_count).to be 1
    passenger.alights(train, passenger)
    expect(train.passengers_in_train_count).to be 0
  end

end