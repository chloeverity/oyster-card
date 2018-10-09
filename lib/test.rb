@journey_history = []

journey = {
  'Entry Station' => 'Charing Cross',
  'Exit Station' => 'Euston',
}

@journey_history << journey


# def touch_in(station)
#   @journey_history << { 'Entry Station' => station }
#   @entry_station = station
# end
#
# def touch_out(fare=1, station)
#   @journey_history[-1]['Exit Jounrey'] = station
#   deduct(fare)
#   @entry_station = nil
# end
