# frozen_string_literal: true

RSpec.describe SpeedtestNet::CalculateSpeed do
  let(:integers) { [1, 2, 3, 4, 5, 6, 7, 8, 9, 10] }
  let(:floats) { [1.1, 2.2, 3.3, 4.4, 5.5, 6.6, 7.7, 8.8, 9.9, 10.10, 11.11] }
  let(:various) { [nil, 'string', :symbol, 1, 2.0, 3 / 1r, 4, 5.0] }

  describe '.call' do
    it 'argument is all integers was valid' do
      expect(described_class.call(integers)).to eq(6.5)
    end

    it 'argument is all floats was valid' do
      expect(described_class.call(floats).round(8)).to eq(7.57142857)
    end

    it 'argument is various types was valid' do
      expect(described_class.call(various)).to eq(3.5)
    end
  end
end
