# frozen_string_literal: true

RSpec.describe SpeedtestNet::Upload do
  describe '.measure' do
    let(:config) { build(:config) }
    let(:server) { build(:server) }
    let(:hydra_mock) { instance_double(Typhoeus::Hydra) }
    let(:request_mock) { instance_double(Typhoeus::Request) }
    let(:response_mock) { instance_double(Typhoeus::Response) }

    before do
      allow(SpeedtestNet::Config).to receive(:fetch).and_return(config)
      allow(Typhoeus::Hydra).to receive(:new).and_return(hydra_mock)
      allow(Typhoeus::Request).to receive(:new).and_return(request_mock)
      allow(hydra_mock).to receive(:queue)
      allow(hydra_mock).to receive(:run)
      allow(request_mock).to receive(:on_complete).and_yield(response_mock)
      allow(response_mock).to receive(:speed_upload).and_return(0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1.0)
    end

    it 'was valid' do
      expect(described_class.measure(server)).to be_instance_of(SpeedtestNet::MeasureResult)
    end
  end
end
