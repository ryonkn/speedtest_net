# frozen_string_literal: true

RSpec.describe SpeedtestNet::Server do # rubocop:disable Metrics/BlockLength
  describe '.list' do # rubocop:disable Metrics/BlockLength
    let(:servers) do
      VCR.use_cassettes [{ name: 'config' }, { name: 'server' }] do
        described_class.list
      end
    end

    context 'when access was' do
      it 'success' do
        expect(servers.count).to be(8919)
      end
    end

    context 'when access error was' do
      before do
        curl_mock = instance_double(Curl::Easy)
        allow(Curl::Easy).to receive(:new).and_return(curl_mock)
        allow(curl_mock).to receive_messages('follow_location=': true,
                                             perform: true,
                                             response_code: 500)
      end

      it 'raise error' do
        VCR.use_cassette 'config' do
          expect { described_class.list }.to raise_error(
            SpeedtestNet::HTTPDownloadError
          )
        end
      end
    end

    context 'when first instance' do
      it 'id was valid' do
        expect(servers.first.id).to eq(15_047)
      end

      it 'distance was valid' do
        expect(servers.first.distance.round).to eq(960)
      end
    end
  end

  describe '.best_server' do
    before do
      latencies = 1.upto(100).map { |i| i / 10.0 }
      allow(SpeedtestNet::Latency).to receive(:measure).and_return(latencies)
    end

    let(:best_server) do
      VCR.use_cassettes [{ name: 'config' }, { name: 'server' }] do
        described_class.best_server
      end
    end

    it 'id was valid' do
      expect(best_server.id).to eq(15_047)
    end
  end

  describe '#measure_latency' do
    before do
      allow(SpeedtestNet::Latency).to receive(:measure).and_return(5.0)
    end

    it 'was valid' do
      server = build(:server)
      server.measure_latency
      expect(server.latency).to eq(5.0)
    end
  end
end
