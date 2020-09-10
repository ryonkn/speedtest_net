# frozen_string_literal: true

RSpec.describe SpeedtestNet::Formatter::Latency do
  describe '.call' do
    it 'argument 0.12345 return "123.450000 millisecond"' do
      expect(described_class.call(0.12345)).to eq('123.450000 millisecond')
    end
  end
end
