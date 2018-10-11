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

    it 'should return true during a journey' do
      subject.instance_variable_set(:@balance, 10)
      subject.touch_in(station)
      expect(subject.in_journey?).to eq true
    end

    it 'should return false after a journey is complete' do
      subject.instance_variable_set(:@balance, 10)
      subject.touch_in(station)
      subject.touch_out(station)
      expect(subject.in_journey?).to eq false
    end
  end

  describe '#touch_in' do
    #before { subject.instance_variable_set(:@balance, 10) }
    it 'should reduce balance by penalty amount if no check out before check in' do
      subject.instance_variable_set(:@balance, 10)
      subject.instance_variable_set(:@in_journey, true)
      expect { subject.touch_in(station) }.to change{ subject.balance }.by(-6)
    end

    it 'should set oystercard to in journey' do
      subject.instance_variable_set(:@balance, 10)
      subject.touch_in(station)
      expect(subject).to be_in_journey
    end

    it 'raises an error if insufficient funds' do
      expect { subject.touch_in(station) }.to raise_error("Insufficient funds")
    end
  end

  describe '#touch_out' do
    it 'should reduce balance by journey amount' do
      subject.instance_variable_set(:@balance, 10)
      subject.touch_in(station)
      expect { subject.touch_out(station) }.to change{ subject.balance }.by(-1)
    end

    it 'should reduce balance by penalty amount if no check in' do
      subject.instance_variable_set(:@balance, 10)
      expect { subject.touch_out(station) }.to change{ subject.balance }.by(-6)
    end
  end

end
