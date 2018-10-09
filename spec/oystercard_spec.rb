require 'oystercard'

describe OysterCard do
let (:station) { double :station }

  describe '#balance' do
    it 'a new card should have a defualt balance of 0' do
      expect(subject.balance).to eq 0
    end
  end

  describe '#top_up' do
    it "tops up the balance on the oyster card" do
      subject.top_up(5)
      expect(subject.balance).to eq 5
    end

    it "should raise error if exceeding maximum balance" do
      max = OysterCard::DEFAULT_MAX_BALANCE
      error_message = "Maximum balance (#{max}) exceeded"
      expect { subject.top_up(max + 1) }.to raise_error(error_message)
    end
  end

  describe '#in_journey?' do
    it 'should default as false' do
      expect(subject.in_journey?).to eq false
    end
  end

  describe '#touch_in' do
    it 'should set oystercard to in journey' do
      subject.touch_in(station)
      expect(subject).to be_in_journey
    end

    it 'should record the entry station' do
      subject.instance_variable_set(:@balance, 10)
      subject.touch_in(station)
      expect(subject.entry_station).to eq station
    end

    it 'should add Entry Station to journeys hash' do
      subject.instance_variable_set(:@balance, 10)
      subject.instance_variable_set(:@entry_station, station)
      subject.touch_in(station)
      expect(subject.journey_history[0]).to eq ({'Entry Station' => station})

    end

  end

  describe '#touch_out' do

    it 'deducts the fare from the balance on the oystercard' do
      subject.instance_variable_set(:@balance, 10)
      subject.instance_variable_set(:@journey_history, [{}])
      subject.touch_out(5, station)
      expect(subject.balance).to eq 5
    end

    it 'raises an error if insufficient funds' do
      min = OysterCard::DEFAULT_MIN_BALANCE
      subject.instance_variable_set(:@journey_history, [{}])
      expect { subject.touch_out(min + 1, station) }.to raise_error("Insufficient funds")
    end


    it 'should set oystercard to not in journey' do
      subject.instance_variable_set(:@balance, 10)
      subject.instance_variable_set(:@journey_history, [{}])
      subject.touch_out(1, station)
      expect(subject).not_to be_in_journey
    end

    it 'should reduce balance by journey amount' do
      subject.instance_variable_set(:@balance, 10)
      subject.instance_variable_set(:@journey_history, [{}])
      expect { subject.touch_out(1, station) }.to change{ subject.balance }.by(-1)
    end

    it 'should reset entry_station to nil' do
      subject.instance_variable_set(:@balance, 10)
      subject.instance_variable_set(:@entry_station, station)
      subject.instance_variable_set(:@journey_history, [{}])
      subject.touch_out(1, station)
      expect(subject.entry_station).to eq nil
    end

    it 'should add exit station to journey hash' do
      subject.instance_variable_set(:@balance, 10)
      subject.instance_variable_set(:@entry_station, station)
      subject.instance_variable_set(:@journey_history, [{'Entry Station' => 'Euston'}])
      subject.touch_out(1, station)
      expect(subject.journey_history[0]).to eq ({'Entry Station' => 'Euston', 'Exit Station' => station})
    end

  end

  describe '#journey_history_list' do
    it 'should print list of previous journey' do
      list = 'Entry Station: Euston, Exit Station: Charing Cross'
      hash_list = [{'Entry Station' => 'Euston', 'Exit Station' => 'Charing Cross'}]
      subject.instance_variable_set(:@journey_history, hash_list)
      expect(subject.journey_history_list).to eq [list]
    end
  end

end
