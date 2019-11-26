# frozen_string_literal: true

FactoryBot.define do
  factory :result, class: 'SpeedtestNet::Result' do
    client { build(:config).client }
    server do
      server = build(:server)
      server.instance_variable_set(:@latency, 0.12345)
      server
    end
    download_results { 1.upto(8).map { |i| i * 1.0 } }
    upload_results { 1.upto(8).map { |i| i * 1_000_000_000_000.0 } }

    initialize_with { new(client, server, download_results, upload_results) }
  end
end
