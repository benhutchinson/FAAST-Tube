class Passenger

  MINIMUM_CREDIT_REQUIRED = 2
  DEFAULT_CREDIT = MINIMUM_CREDIT_REQUIRED

  attr_reader :credit
  attr_accessor :current_location
  attr_accessor :entered_station

  def initialize(creditparam = {})
    @credit = creditparam.fetch(:credit, DEFAULT_CREDIT)
    @entered_station = false
  end

  def has_credit?
    credit >= MINIMUM_CREDIT_REQUIRED
  end

  def out_of_credit?
    credit < MINIMUM_CREDIT_REQUIRED
  end

  def boards(train, station)
    raise TrainNotInStation unless station.train_arrived?(train) 
    raise TrainFull if train.full?
    raise PassengerNotInStationYet unless entered_station
    train.passengers_in_train.push(self)
    station.passengers_in_station.delete(self)
    @entered_station = false
  end

  def alights(train, station)
    raise TrainNotInStation unless station.train_arrived?(train)
    raise StationFull if station.full_of_passengers?
    train.passengers_in_train.delete(self)
    station.passengers_in_station.push(self)
    @entered_station = true
  end

end


