class Passenger

  def initialize
    has_credit?
    # this will be the required 2GBP to touch-in
  end

  def has_credit?
    @credit = true
  end

  def out_of_credit
    @credit = false
  end


end