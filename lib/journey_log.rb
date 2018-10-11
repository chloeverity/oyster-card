require 'journey'

class JourneyLog
  def initialize
    @journey_history = []
  end

  attr_reader :new_journey, :journey_fare

  def begin(station)
    @new_journey = Journey.new
    @new_journey.start(station)
  end

  def finish(station)
    @new_journey ||= Journey.new
    @new_journey.end(station)
    log
  end

  def journey_history
    @journey_history.dup
  end

private
  def log
    @journey_history << @new_journey.journey_info
  end

end
