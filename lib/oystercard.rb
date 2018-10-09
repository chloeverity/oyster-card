require 'journey'

class OysterCard

  DEFAULT_MAX_BALANCE = 90
  DEFAULT_MIN_BALANCE = 1
  PENALTY_FARE = Journey::PENALTY_FARE

  attr_reader :balance, :entry_station, :journey_history

  def initialize
    @balance = 0
    @journey_history = []
    @in_journey = false
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
    add_journey_info 
  #  @entry_station = nil
  #  @journey_history[-1]['Exit Station'] = station
  end

  def add_journey_info
    @journey_history << @new_journey.journey_info
  end

  private
  def deduct(amount)
    @balance -= amount
  end

end
