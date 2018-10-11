class Journey
  MIN_FARE = 1
  PENALTY_FARE = 6

  def initialize
    @entry_station = nil
    @exit_station = nil
  end

  attr_reader :entry_station, :exit_station, :fare

  def start(station)
    @entry_station = station
  end

  def end(station)
    @exit_station = station
  end

  def complete?
    !!(entry_station && exit_station)
    # return false if (@entry_station == nil) || (@exit_station == nil)
    # true
  end

  def fare
    complete? ? MIN_FARE : PENALTY_FARE
  end

  def journey_info
    {entry: @entry_station,
    exit: @exit_station}
  end

end
