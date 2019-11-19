# frozen_string_literal: true

RSpec.describe SpeedtestNet::Upload do
  subject(:measure) { described_class.measure(server) }

  let(:config) { build(:config) }
  let(:server) { build(:server) }
  let(:easy_mock) { instance_double(Curl::Easy) }
  let(:fake_speed) { 1.upto(10).map { |i| i / 10.0 } }

  before do
    allow(SpeedtestNet::Config).to receive(:fetch).and_return(config)
    allow(Curl::Multi).to receive(:post).and_yield(easy_mock)
    allow(easy_mock).to receive(:upload_speed).and_return(*fake_speed)
  end

  describe '.measure' do
    it 'was valid' do
      expect(measure).to eq(5.2)
    end
  end
end
