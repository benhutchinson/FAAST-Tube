class StationIsFullOfTrains < Exception
  def message
    "The station is currently full of trains."
  end
end


class Train

  MINIMUM_COACHES = 1

  def initialize(define_coaches = {})
    @coach_count = define_coaches.fetch(:coaches, MINIMUM_COACHES)
    @capacity = @coach_count * 40
    @passengers_in_train = []
  end

  attr_reader :capacity
  attr_reader :passengers_in_train

  def full?
    passengers_in_train.count == capacity
  end

  def arrives_at_station(station)
    raise StationIsFullOfTrains if station.full_of_trains?
    station.train_at_station.push(self)
  end

  def departs_from_station(station)
    station.train_at_station.delete(self)
  end

end