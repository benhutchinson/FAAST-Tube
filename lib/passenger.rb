class NoCredit < Exception
  def message
    "Passenger does not have credit required"
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


end