require 'journey'

class JourneyLog
  def initialize
    @journey_history = []
  end

attr_reader :journey_class

def begin(station)
  @new_journey = Journey.new
  @new_journey.start(station)
end

def finish(station)
  @new_journey ||= Journey.new
  @new_journey.end(station)
  log
end

def log
  @journey_history << @new_journey.journey_info
end
