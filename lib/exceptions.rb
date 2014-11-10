class StationIsFullOfTrains < Exception
  def message
    "The station is currently full of trains."
  end
end

class PassengerNotInStation < Exception
  def message
    "Passenger is not currently in the station."
  end
end

class NoCredit < Exception
  def message
    "Passenger does not have credit required"
  end
end

class TrainFull < Exception
  def message
    "Train is full"
  end
end

class TrainNotInStation < Exception
  def message
    "Train Is Not In Station So Passengers Cannot Board Or Alight"
  end
end

class PassengerNotInStationYet < Exception
  def message
    "Passenger must enter station in order to board train"
  end
end

class StationFull < Exception
  def message
    "Station Is Full, No More Passengers Can Come In"
  end
end

class PassengerInAnotherStationAlready < Exception
  def message
    "This passenger is already in another station"
  end
end

class TrainStillAtAnotherStation < Exception
  def message
    "The train has not yet left another station"
  end
end

class TrainNotHere < Exception
  def message
    "The train is not here so cannot depart from this station"
  end
end
