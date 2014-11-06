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
    @train_at_station = []
  end

  attr_reader :capacity
  attr_reader :passengers_in_station
  attr_reader :train_at_station

  def allow_in(passenger)
    raise NoCredit if passenger.out_of_credit?
    raise StationFull if full?
    passengers_in_station << passenger
  end

  def release(passenger)
    passengers_in_station.delete(passenger)
  end

  def full?
    passengers_in_station.count == capacity
  end

  # def docks(train, station)
  #   train_at_station << train
  # end

  # def undocks(train, station)
  #   train_at_station.delete(train)
  # end

  def train_arrived?(train)
    train_at_station.include?(train)
  end

  def train_departed?(train)
    !train_at_station.include?(train)
  end
  
end
