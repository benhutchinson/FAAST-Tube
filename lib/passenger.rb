class NoCredit < Exception
  def message
    "Passenger does not have credit required"
  end
end

class TrainFull < Exception
  def message
    "Train is full"
  end
end

class TrainNotInStation < Exception
  def message
    "Train Is Not In Station So Passengers Cannot Board Or Alight"
  end
end

class PassengerNotInStationYet < Exception
  def message
    "Passenger must enter station in order to board train"
  end
end

class StationFull < Exception
  def message
    "Station Is Full, No More Passengers Can Come In"
  end
end

class Passenger

  MINIMUM_CREDIT_REQUIRED = 2
  DEFAULT_CREDIT = MINIMUM_CREDIT_REQUIRED

  def initialize(creditparam = {})
    @credit = creditparam.fetch(:credit, DEFAULT_CREDIT)
    @entered_station = false
  end

  attr_reader :credit
  attr_accessor :current_location
  attr_accessor :entered_station

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
  end

  def alights(train, station)
    raise TrainNotInStation unless station.train_arrived?(train)
    raise StationFull if station.full_of_passengers?
    train.passengers_in_train.delete(self)
    station.passengers_in_station.push(self)
  end

end