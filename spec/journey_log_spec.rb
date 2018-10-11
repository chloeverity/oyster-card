require 'journey_log'

describe JourneyLog do
  let (:journey) {double :journey}

  describe '#begin' do
    it 'creates a new instance of journey' do
    subject.begin("station")
    expect(subject.new_journey).to be_an_instance_of(Journey)
    end
  end

  describe '#finish' do
    it 'creates a new instance of journey' do
    subject.finish("station")
    expect(subject.new_journey).to be_an_instance_of(Journey)
    end
  end

end
