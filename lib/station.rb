class StationFull < Exception
  def message
    "Station Is Full, No More Passengers Can Come In"
  end
end

class Station

  DEFAULT_CAPACITY = 1000

  def initialize(define_capacity = {})
    @capacity = define_capacity.fetch(:capacity, DEFAULT_CAPACITY)
    @passengers = []
  end

  attr_reader :capacity

  def passenger_count
    @passengers.count
  end

  def allow_in(passenger)
    raise NoCredit if passenger.credit == false
    raise StationFull if full?
    @passengers << passenger
  end

  def release(passenger)
    @passengers.delete(passenger)
  end

  def full?
    passenger_count == @capacity
  end

end
