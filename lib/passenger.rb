class NoCredit < Exception
  def message
    "Passenger does not have credit required"
  end
end


class Passenger

  DEFAULT_CREDIT = true

  def initialize(creditparam = {})
    @credit = creditparam.fetch(:credit, DEFAULT_CREDIT)
    # this will be the required 2GBP to touch-in
  end

  attr_reader :credit

  def has_credit?
    @credit = true
  end

  def out_of_credit
    true if @credit == false
  end


end