require 'journey'
require 'journey_log'

class OysterCard

  DEFAULT_MAX_BALANCE = 90
  DEFAULT_MIN_BALANCE = 1
  PENALTY_FARE = Journey::PENALTY_FARE

  attr_reader :balance, :entry_station, :journey_history

  def initialize
    @balance = 0
    @in_journey = false
    @journey_log = JourneyLog.new
  end

  def top_up(amount)
    error_message = "Maximum balance (#{DEFAULT_MAX_BALANCE}) exceeded"
    raise error_message if (@balance + amount) > DEFAULT_MAX_BALANCE
    @balance += amount
  end

  def in_journey?
    @in_journey
  end

  def touch_in(station)
    deduct(PENALTY_FARE) if in_journey?
    raise("Insufficient funds") if @balance < DEFAULT_MIN_BALANCE
    @new_journey = Journey.new
    @new_journey.start(station)
    @in_journey = true
    #@entry_station = station
    #@journey_history << { 'Entry Station' => station }
  end

  def touch_out(station)
    @new_journey ||= Journey.new
    @new_journey.end(station)
    deduct(@new_journey.fare)
    @in_journey = false
  #  @entry_station = nil
  #  @journey_history[-1]['Exit Station'] = station
  end

  private
  def deduct(amount)
    @balance -= amount
  end

end
