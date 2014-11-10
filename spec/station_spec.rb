require 'station'
require 'exceptions'

describe "A Station" do 

  let(:station) { Station.new(:capacity => 500) }
  let(:small_station) { Station.new(:capacity => 2)}
  let(:passenger) { Passenger.new() }
  let(:passenger2) { Passenger.new() }
  let(:passenger_no_credit) { Passenger.new(:credit => 1)}
  let(:train) { Train.new }


  def let_a_passenger_with_credit_touch_in
    station.allow_in(passenger)
  end

  it "should let passengers with credit touch in and enter the station" do
    let_a_passenger_with_credit_touch_in
    expect(station.passengers_in_station.count).to eq 1
  end

  it "should not allow a passenger into the station if they do not have credit" do
    expect{station.allow_in(passenger_no_credit)}.to raise_error NoCredit
  end


  context "When It Is Full Of Passengers" do

    before :each do 

      def fill_station_with_passengers(small_station)
        small_station.allow_in(passenger)
        small_station.allow_in(passenger2)
      end

      fill_station_with_passengers(small_station)

    end

    it "should know if it is full with passengers" do
      expect(small_station).to be_full_of_passengers
    end

    it "should not allow a passenger in if it is full" do
      expect{small_station.allow_in(passenger)}.to raise_error(StationFull)
    end

    it "should not allow a passenger to alight a train if full" do 
      train.arrives_at_station(small_station)
      expect{passenger.alights(train, small_station)}.to raise_error(StationFull)
    end

  end


  context "When A Passenger Tries To Leave" do

    before :each do 

      let_a_passenger_with_credit_touch_in

    end

    it "should allow passengers that are in the station to leave the station" do
      station.release(passenger)
      expect(station.passengers_in_station.count).to eq 0
    end

    it "should not allow a passenger to leave if not in the station" do
      train.arrives_at_station(station)
      passenger.boards(train, station)
      expect{station.release(passenger)}.to raise_error PassengerNotInStation
    end

  end


  context "When A Train Has Arrived" do

    before :each do 

      train.arrives_at_station(station)

    end

    it "must be able to recognise that a train has arrived" do
      expect(station.train_arrived?(train)).to be true
    end

    it "must be able to recognise when that train has left" do
      train.departs_from_station(station)
      expect(station.train_departed?(train)).to be true
    end

    it "should know if it is full of trains" do
      station.train_capacity = 1
      expect(station.full_of_trains?).to be true
    end

  end

end