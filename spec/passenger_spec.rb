require 'passenger'

describe Passenger  do
  
  let (:passenger) { Passenger.new } 

  it "should start out with credit" do 
    # start with a bare-bones type feature
    # that we expect to be present
    # let's test this feature
    expect(passenger).to have_credit
  end

  
end