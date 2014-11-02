class Train

  MINIMUM_COACHES = 1

  def initialize(define_coaches = {})
    @coach_count = define_coaches.fetch(:coaches, MINIMUM_COACHES)
    @capacity = @coach_count * 40
    @passengers_in_train = []
  end

  attr_reader :capacity
  attr_reader :passengers_in_train

  def passengers_in_train_count
    passengers_in_train.count
  end

  def full?
    passengers_in_train_count == capacity
  end

end