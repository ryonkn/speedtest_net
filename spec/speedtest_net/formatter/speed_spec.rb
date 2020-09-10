# frozen_string_literal: true

RSpec.describe SpeedtestNet::Formatter::Speed do
  describe '.call' do
    it 'argument 1 return "1.00 bps"' do
      expect(described_class.call(1)).to eq('1.00 bps')
    end

    it 'argument 1_000 return "1.00 Kbps"' do
      expect(described_class.call(1_000)).to eq('1.00 Kbps')
    end

    it 'argument 1_000_000 return "1.00 Mbps"' do
      expect(described_class.call(1_000_000)).to eq('1.00 Mbps')
    end

    it 'argument 1_000_000_000 return "1.00 Gbps"' do
      expect(described_class.call(1_000_000_000)).to eq('1.00 Gbps')
    end

    it 'argument 1_000_000_000_000 return "1.00 Tbps"' do
      expect(described_class.call(1_000_000_000_000)).to eq('1.00 Tbps')
    end
  end
end
