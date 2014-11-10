class Passenger

  MINIMUM_CREDIT_REQUIRED = 2
  DEFAULT_CREDIT = MINIMUM_CREDIT_REQUIRED

  attr_reader :credit
  attr_accessor :entered_station

  def initialize(creditparam = {})
    @credit = creditparam.fetch(:credit, DEFAULT_CREDIT)
    @entered_station = false
  end

  def has_credit?
    credit >= MINIMUM_CREDIT_REQUIRED
  end

  def out_of_credit?
    !has_credit?
  end

  def boards(train, station)
    raise TrainNotInStation unless station.train_arrived?(train) 
    raise TrainFull if train.full?
    raise PassengerNotInStationYet unless entered_station
    train.passenger_boards_train(self)
    station.passenger_boards_train(self)
    @entered_station = false
  end

  def alights(train, station)
    raise TrainNotInStation unless station.train_arrived?(train)
    raise StationFull if station.full_of_passengers?
    train.passenger_alights_train(self)
    station.passenger_alights_train(self)
    @entered_station = true
  end

end


