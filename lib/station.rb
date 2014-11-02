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
    raise if full?
    @passengers << passenger
  end

  def release(passenger)
    @passengers.delete(passenger)
  end

  def full?
    passenger_count == @capacity
  end

end
