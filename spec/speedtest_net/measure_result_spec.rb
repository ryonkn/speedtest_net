# frozen_string_literal: true

RSpec.describe SpeedtestNet::MeasureResult do
  let(:integers) { [1, 2, 3, 4, 5, 6, 7, 8, 9, 10] }
  let(:floats) { [1.1, 2.2, 3.3, 4.4, 5.5, 6.6, 7.7, 8.8, 9.9, 10.10, 11.11] }
  let(:various) { [nil, 'string', :symbol, 1, 2.0, 3 / 1r, 4, 5.0] }

  describe '#calculate' do
    it 'argument is all integers was valid' do
      expect(described_class.new(integers).calculate).to eq(6.5)
    end

    it 'argument is all floats was valid' do
      expect(described_class.new(floats).calculate.round(8)).to eq(7.57142857)
    end

    it 'argument is various types was valid' do
      expect(described_class.new(various).calculate).to eq(3.5)
    end
  end
end
