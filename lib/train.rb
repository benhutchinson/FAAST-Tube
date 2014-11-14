class Train

  MINIMUM_COACHES = 1

  attr_reader :capacity, :passengers_in_train

  def initialize(define_coaches = {})
    @coach_count = define_coaches.fetch(:coaches, MINIMUM_COACHES)
    @capacity = @coach_count * 40
    @passengers_in_train = []
    @at_a_station = false
  end

  def full?
    @passengers_in_train.count == @capacity
  end

  def arrives_at_station(station)
    raise TrainStillAtAnotherStation if @at_a_station == true
    raise StationIsFullOfTrains if station.full_of_trains?
    station.train_arrives_at_station(self)
    @at_a_station = true
  end

  def departs_from_station(station)
    raise TrainNotHere if @at_a_station == false
    station.train_departs_from_station(self)
    @at_a_station = false
  end

  def passenger_alights_train(passenger)
    @passengers_in_train.delete(passenger)
  end

  def passenger_boards_train(passenger)
    @passengers_in_train.push(passenger)
  end

end

