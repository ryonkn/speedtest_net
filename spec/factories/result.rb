# frozen_string_literal: true

FactoryBot.define do
  factory :result, class: 'SpeedtestNet::Result' do
    client { build(:config).client }
    server do
      server = build(:server)
      server.instance_variable_set(:@latency, 0.12345)
      server
    end
    download_result { build(:download_result) }
    upload_result { build(:upload_result) }

    initialize_with { new(client, server, download_result, upload_result) }
  end
end
