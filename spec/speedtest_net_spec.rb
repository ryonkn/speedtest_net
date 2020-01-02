# frozen_string_literal: true

RSpec.describe SpeedtestNet do
  describe '.run' do
    subject(:run) { described_class.run }

    let(:config) { build(:config) }
    let(:server) { build(:server) }

    before do
      allow(SpeedtestNet::Config).to receive(:fetch).and_return(config)
      allow(SpeedtestNet::Server).to receive(:select_server).and_return(server)
      allow(SpeedtestNet::Download).to receive(:measure).and_return(123_456.789)
      allow(SpeedtestNet::Upload).to receive(:measure).and_return(987_654.31)
    end

    it 'was valid' do
      expect(run).to be_instance_of(SpeedtestNet::Result)
    end
  end

  describe '.list_server' do
    context 'when access was' do
      it 'success' do
        VCR.use_cassettes [{ name: 'config' }, { name: 'server' }] do
          servers = described_class.list_server
          expect(servers.count).to be(8919)
        end
      end
    end
  end
end
