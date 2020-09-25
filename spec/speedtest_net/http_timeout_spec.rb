# frozen_string_literal: true

RSpec.describe SpeedtestNet do
  it 'has a http_timeout' do
    expect(SpeedtestNet::HTTP_TIMEOUT).to eq 180
  end
end
