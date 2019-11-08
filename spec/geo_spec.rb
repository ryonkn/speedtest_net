# frozen_string_literal: true

RSpec.describe Geo do
  let(:point1) { described_class.new(51.48, 0.00) }
  let(:point2) { described_class.new(35.71, 139.81) }

  describe '#lat' do
    it 'was valid' do
      expect(point1.lat).to eq(51.48)
    end
  end

  describe '#long' do
    it 'was valid' do
      expect(point1.long).to eq(0.00)
    end
  end

  describe '#distance' do
    it 'was valid' do
      expect(point1.distance(point2)).to eq(9_558_874.254355017)
    end
  end
end
