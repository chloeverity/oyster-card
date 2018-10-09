require 'journey'

describe Journey do
let (:station1) { double(:station1) }
let (:station2) { double(:station2) }
let (:min_fare) { Journey::MIN_FARE }
let (:penalty_fare) { Journey::PENALTY_FARE }

  describe "#start" do
    it 'starts journey at the entry station' do
      subject.start("station")
      expect(subject.entry_station).to eq "station"
    end
  end

  describe "#end" do
    it 'ends journey at the exit station' do
      subject.start("station")
      subject.end("station2")
      expect(subject.exit_station).to eq "station2"
    end
  end

  describe "complete?" do
    it 'returns true if the journey had a start and end point' do
      subject.start(station1)
      subject.end(station2)
      expect(subject.complete?).to eq true
    end

    it 'returns false if the journey has no start' do
      subject.end(station2)
      expect(subject.complete?).to eq false
    end

      it 'returns false if the journey has no end' do
        subject.start(station1)
        expect(subject.complete?).to eq false
    end
  end

  describe "#fare" do
    it 'returns the minimum fare if journey complete' do
      subject.start(station1)
      subject.end(station2)
      expect(subject.fare).to eq min_fare
    end

    it 'returns a penalty fare if journey is incomplete' do
      subject.start(station1)
      expect(subject.fare).to eq penalty_fare
    end
  end

  describe "#journey_info" do
    it 'returns a hash with the information about the journey' do
      subject.start(station1)
      subject.end(station2)
      expect(subject.journey_info).to eq ({entry: station1, exit: station2})
    end
  end

end
