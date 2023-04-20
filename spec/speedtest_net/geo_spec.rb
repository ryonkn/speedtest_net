# frozen_string_literal: true

RSpec.describe SpeedtestNet::Geo do
  let(:point) { described_class.new(51.48, 0.01) }
  let(:other_point) { described_class.new(35.71, 139.81) }

  describe '#distance' do
    it 'was valid' do
      expect(point.distance(other_point).round).to eq(9_558_510)
    end
  end

  describe '#radian_lat' do
    it 'was valid' do
      expect(point.radian_lat).to eq(0.8984954989266808)
    end
  end

  describe '#radian_long' do
    it 'was valid' do
      expect(point.radian_long).to eq(0.00017453292519943296)
    end
  end
end
