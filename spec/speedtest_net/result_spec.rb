# frozen_string_literal: true

RSpec.describe SpeedtestNet::Result do # rubocop:disable Metrics/BlockLength
  let(:result) { build(:result) }

  describe '#client' do
    it 'was valid' do
      expect(result.client).to include(ip: '127.0.0.1', isp: 'example isp')
    end
  end

  describe '#server' do
    it 'was valid' do
      expect(result.server.url).to eq('http://example.com')
    end
  end

  describe '#download' do
    it 'was valid' do
      expect(result.download).to eq(123_456_789_123_456.78)
    end
  end

  describe '#upload' do
    it 'was valid' do
      expect(result.upload).to eq(123.456)
    end
  end

  describe '#pretty_download' do
    it 'was valid' do
      expect(result.pretty_download).to eq('123.46 Tbps')
    end
  end

  describe '#pretty_upload' do
    it 'was valid' do
      expect(result.pretty_upload).to eq('123.46 bps')
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
      expect(result.pretty_distance).to eq('1234.568 kilometre')
    end
  end
end
