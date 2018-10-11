require 'journey_log'

describe JourneyLog do
  it 'accepts journey_class as a parameter' do
    journey = Journey.new
    journey_log = JourneyLog.new(journey)
    expect(journey_log.journey_class).to eq journey
  end
end
