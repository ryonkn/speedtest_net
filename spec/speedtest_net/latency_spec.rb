# frozen_string_literal: true

# rubocop:disable RSpec/MultipleMemoizedHelpers
RSpec.describe SpeedtestNet::Latency do
  subject(:measure) { described_class.measure(server) }

  let(:config) { build(:config) }
  let(:server) { build(:server) }
  let(:request_mock) { instance_double(Typhoeus::Request) }
  let(:response_mock) { instance_double(Typhoeus::Response) }
  let(:fake_latencies) { 10.downto(1).map { |i| i / 10.0 } }
  let(:default_latency) { described_class::DEFAULT_LATENCY }

  before do
    allow(SpeedtestNet::Config).to receive(:fetch).and_return(config)
    allow(Typhoeus::Request).to receive(:new).and_return(request_mock)
    allow(request_mock).to receive(:run)
    allow(request_mock).to receive(:response).and_return(response_mock)
    allow(response_mock).to receive(:total_time).and_return(*fake_latencies)
  end

  describe '.measure' do
    context 'when response code is 200' do
      before do
        allow(response_mock).to receive(:response_code).and_return(200)
      end

      it 'was valid' do
        expect(measure).to be(fake_latencies.min)
      end
    end

    context 'when response code is not 200' do
      before do
        allow(response_mock).to receive(:response_code).and_return(500)
      end

      it 'was valid' do
        expect(measure).to be(default_latency)
      end
    end
  end
end
# rubocop:enable RSpec/MultipleMemoizedHelpers
