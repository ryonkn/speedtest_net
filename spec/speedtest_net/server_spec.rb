# frozen_string_literal: true

RSpec.describe SpeedtestNet::Server do
  describe '.list' do
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
        request_mock = instance_double(Typhoeus::Request)
        response_mock = instance_double(Typhoeus::Response)

        allow(Typhoeus::Request).to receive(:new).and_return(request_mock)
        allow(request_mock).to receive_messages(run: true, response: response_mock)
        allow(response_mock).to receive_messages(code: 500)
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

  describe '.select_server' do
    before do
      latencies = 1.upto(100).map { |i| i / 10.0 }
      allow(SpeedtestNet::Latency).to receive(:measure).and_return(latencies)
    end

    context 'when server id not set' do
      let(:select_server) do
        VCR.use_cassettes [{ name: 'config' }, { name: 'server' }] do
          described_class.select_server
        end
      end

      it 'was valid' do
        expect(select_server.id).to eq(15_047)
      end
    end

    context 'when server id set' do
      let(:select_server) do
        VCR.use_cassettes [{ name: 'config' }, { name: 'server' }] do
          described_class.select_server(999)
        end
      end

      it 'was valid' do
        expect(select_server.id).to eq(999)
      end
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
