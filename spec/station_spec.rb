require 'station'

describe Station do

  it 'should include a name and a zone' do
    name = "Euston"
    zone = 1
    station = Station.new("Euston", 1)
    expect(station.name).to eq "Euston"
    expect(station.zone).to eq 1
  end

end
