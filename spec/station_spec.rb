require 'station'

describe Station do 

  let(:station) { Station.new(:capacity => 500) }
  let(:passenger) { Passenger.new }
  let(:passenger_no_credit) { Passenger.new(:credit => false)}

  def fill_station_with_passengers(station)
    station.capacity.times {station.allow_in(passenger)}
  end

  it "must let passengers with credit touch in" do
    expect(station.passenger_count).to eq 0
    station.allow_in(passenger)
    expect(station.passenger_count).to eq 1
  end

  it "must let passengers leave the station" do
    station.allow_in(passenger)
    station.release(passenger)
    expect(station.passenger_count).to eq 0
  end

  it "should know if it is full with passengers" do
    expect(station).not_to be_full
    fill_station_with_passengers(station)
    expect(station).to be_full
  end

  it "should not allow a passenger in if it is full" do
    fill_station_with_passengers(station)
    expect{ station.allow_in(passenger) }.to raise_error(StationFull)
  end

  it "should not allow a passenger in if they do not have credit" do
    expect {station.allow_in(passenger_no_credit)}.to raise_error NoCredit
  end

  # it "must be able to let trains arrive" do
  # end


  # if train wants to go, must release it
  # if train wants to arrive, must accept it provided there is space
  # it should know how much space it has for trains
  # it must allow passengers with credit to touch in/out


  
end