# frozen_string_literal: true

FactoryBot.define do
  factory :server, class: SpeedtestNet::Server do
    id { 0 }
    url { 'http://example.com' }
    geo { Geo.new(0.0, 0.0) }
    distance { 1_234.56789 }
    server do
      { 'name' => 'example server', 'country' => 'JP', 'cc' => 'JP',
        'sponsor' => 'example', 'host' => 'example.com' }
    end

    initialize_with { new(id, url, geo, distance, server) }
  end
end
