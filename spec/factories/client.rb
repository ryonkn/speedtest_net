# frozen_string_literal: true

FactoryBot.define do
  factory :client, class: 'SpeedtestNet::Client' do
    initialize_with { new('127.0.0.1', 'example isp', SpeedtestNet::Geo.new(0.0, 0.0)) }
  end
end
