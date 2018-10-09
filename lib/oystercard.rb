class OysterCard

  DEFAULT_MAX_BALANCE = 90
  DEFAULT_MIN_BALANCE = 1


  attr_reader :balance, :entry_station, :journey_history

  def initialize
    @balance = 0
    @journey_history = []
  end

  def top_up(amount)
    error_message = "Maximum balance (#{DEFAULT_MAX_BALANCE}) exceeded"
    raise error_message if (@balance + amount) > DEFAULT_MAX_BALANCE
    @balance += amount
  end

  def in_journey?
    @entry_station != nil
  end

  def touch_in(station)
    @entry_station = station
    @journey_history << { 'Entry Station' => station }
  end

  def touch_out(fare=1, station)
    deduct(fare)
    @entry_station = nil
    @journey_history[-1]['Exit Station'] = station
  end

  def journey_history_list
    return @journey_history.map do |journey|
      "Entry Station: #{journey['Entry Station']}, Exit Station: #{journey['Exit Station']}"
    end
  end

  private

  def deduct(amount)
    raise("Insufficient funds") if @balance < DEFAULT_MIN_BALANCE
    @balance -= amount
  end

end
