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

  def boards(train, passenger)
    raise TrainFull if train.full?
    train.passengers_in_train.push(passenger)
  end

  def alights(train, passenger)
    train.passengers_in_train.delete(passenger)
  end

end