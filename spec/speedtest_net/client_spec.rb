# frozen_string_literal: true

RSpec.describe SpeedtestNet::Client do
  let(:client) { build(:client) }

  describe '#ip' do
    it 'was valid' do
      expect(client.ip).to eq('127.0.0.1')
    end
  end

  describe '#isp' do
    it 'was valid' do
      expect(client.isp).to eq('example isp')
    end
  end

  describe '#geo' do
    it 'was valid' do
      expect(client.geo).to be_instance_of(SpeedtestNet::Geo)
    end
  end
end
