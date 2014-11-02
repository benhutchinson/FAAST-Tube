class StationFull < Exception
  def message
    "Station Is Full, No More Passengers Can Come In"
  end
end

class Station

  DEFAULT_CAPACITY = 1000

  def initialize(define_capacity = {})
    @capacity = define_capacity.fetch(:capacity, DEFAULT_CAPACITY)
    @passengers_in_station = []
  end

  attr_reader :capacity
  attr_reader :passengers_in_station
  # is this necessary?

  def passengers_in_station_count
    @passengers_in_station.count
  end

  def allow_in(passenger)
    raise NoCredit if passenger.out_of_credit
    raise StationFull if full?
    @passengers_in_station << passenger
  end

  def release(passenger)
    @passengers_in_station.delete(passenger)
  end

  def full?
    passengers_in_station_count == @capacity
  end

end
