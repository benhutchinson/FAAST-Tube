class Station

  DEFAULT_PASSENGER_CAPACITY = 1000
  DEFAULT_TRAIN_CAPACITY = 2

  attr_accessor :passengers_in_station
  attr_accessor :train_capacity

  def initialize(define_capacity = {})
    @capacity = define_capacity.fetch(:capacity, DEFAULT_PASSENGER_CAPACITY)
    @passengers_in_station = []
    @train_at_station = []
    @train_capacity = DEFAULT_TRAIN_CAPACITY
  end

  def allow_in(passenger)
    raise NoCredit if passenger.out_of_credit?
    raise StationFull if full_of_passengers?
    raise PassengerInAnotherStationAlready if passenger.entered_station
    passengers_in_station << passenger
    passenger.entered_station = true 
  end

  def release(passenger)
    raise PassengerNotInStation unless passengers_in_station.include?(passenger)
    passengers_in_station.delete(passenger)
    passenger.entered_station = false
  end

  def full_of_passengers?
    passengers_in_station.count == @capacity
  end

  def train_arrived?(train)
    @train_at_station.include?(train)
  end

  def train_departed?(train)
    !@train_at_station.include?(train)
  end

  def full_of_trains?
    @train_at_station.count == train_capacity
  end

  def train_arrives_at_station(train)
    @train_at_station.push(train)
  end

  def train_departs_from_station(train)
    @train_at_station.delete(train)
  end

  def passenger_alights_train(passenger)
    passengers_in_station.push(passenger)
  end

  def passenger_boards_train(passenger)
    passengers_in_station.delete(passenger)
  end

end

