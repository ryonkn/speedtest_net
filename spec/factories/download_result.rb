# frozen_string_literal: true

FactoryBot.define do
  factory :download_result, class: 'SpeedtestNet::MeasureResult' do
    results { 1.upto(8).map { |i| i * 1.0 } }

    initialize_with { new(results) }
  end
end
