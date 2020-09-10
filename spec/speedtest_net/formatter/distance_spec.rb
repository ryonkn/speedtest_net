# frozen_string_literal: true

RSpec.describe SpeedtestNet::Formatter::Distance do
  describe '.call' do
    it 'argument 1_234.56789 return "1.235 kilometre"' do
      expect(described_class.call(1_234.56789)).to eq('1.235 kilometre')
    end
  end
end
