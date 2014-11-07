class StationFull < Exception
  def message
    "Station Is Full, No More Passengers Can Come In"
  end
end

class PassengerNotInStation < Exception
  def message
    "Passenger is not currently in the station."
  end
end

class Station

  DEFAULT_PASSENGER_CAPACITY = 1000
  DEFAULT_TRAIN_CAPACITY = 2

  def initialize(define_capacity = {})
    @capacity = define_capacity.fetch(:capacity, DEFAULT_PASSENGER_CAPACITY)
    @passengers_in_station = []
    @train_at_station = []
    @train_capacity = DEFAULT_TRAIN_CAPACITY
  end

  attr_reader :capacity
  attr_reader :passengers_in_station
  attr_reader :train_at_station
  attr_accessor :train_capacity

  def allow_in(passenger)
    raise NoCredit if passenger.out_of_credit?
    raise StationFull if full_of_passengers?
    passengers_in_station << passenger
    passenger.entered_station = true 
  end

  def release(passenger)
    raise PassengerNotInStation unless passengers_in_station.include?(passenger)
    passengers_in_station.delete(passenger)
  end

  def full_of_passengers?
    passengers_in_station.count == capacity
  end

  def train_arrived?(train)
    train_at_station.include?(train)
  end

  def train_departed?(train)
    !train_at_station.include?(train)
  end

  def full_of_trains?
    train_at_station.count == train_capacity
  end
  
end
