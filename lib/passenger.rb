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

class Passenger

  MINIMUM_CREDIT_REQUIRED = 2
  DEFAULT_CREDIT = MINIMUM_CREDIT_REQUIRED

  def initialize(creditparam = {})
    @credit = creditparam.fetch(:credit, DEFAULT_CREDIT)
    # this will be the required 2GBP to touch-in
  end

  attr_reader :credit

  def has_credit?
    true if @credit >= MINIMUM_CREDIT_REQUIRED
  end

  def out_of_credit
    true if @credit < MINIMUM_CREDIT_REQUIRED
  end

  def boards(train, passenger, station)
    raise TrainNotInStation unless station.train_arrived?(train) == true
    raise TrainFull if train.full?
    train.passengers_in_train.push(passenger)
  end

  def alights(train, passenger, station)
    raise TrainNotInStation unless station.train_arrived?(train) == true
    train.passengers_in_train.delete(passenger)
  end

end