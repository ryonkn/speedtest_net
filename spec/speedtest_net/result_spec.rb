# frozen_string_literal: true

RSpec.describe SpeedtestNet::Result do
  let(:result) { build(:result) }

  describe '#client' do
    it 'was valid' do
      expect(result.client.isp).to eq('example isp')
    end
  end

  describe '#server' do
    it 'was valid' do
      expect(result.server.url).to eq('http://example.com')
    end
  end

  describe '#download' do
    it 'was valid' do
      expect(result.download).to eq(5.0)
    end
  end

  describe '#pretty_download' do
    it 'was valid' do
      expect(result.pretty_download).to eq('5.00 bps')
    end
  end

  describe '#upload' do
    it 'was valid' do
      expect(result.upload).to match(5_000_000_000_000.0)
    end
  end

  describe '#pretty_upload' do
    it 'was valid' do
      expect(result.pretty_upload).to eq('5.00 Tbps')
    end
  end

  describe '#latency' do
    it 'was valid' do
      expect(result.latency).to eq(0.12345)
    end
  end

  describe '#pretty_latency' do
    it 'was valid' do
      expect(result.pretty_latency).to eq('123.450000 millisecond')
    end
  end

  describe '#distance' do
    it 'was valid' do
      expect(result.distance).to eq(1234.56789)
    end
  end

  describe '#pretty_distance' do
    it 'was valid' do
      expect(result.pretty_distance).to eq('1.235 kilometre')
    end
  end
end
