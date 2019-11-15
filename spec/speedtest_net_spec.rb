# frozen_string_literal: true

RSpec.describe SpeedtestNet do
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
