# frozen_string_literal: true

FactoryBot.define do
  factory :result, class: 'SpeedtestNet::Result' do
    client { build(:config).client }
    server do
      server = build(:server)
      server.instance_variable_set(:@latency, 0.12345)
      server
    end
    download { build(:download) }
    upload { build(:upload) }

    initialize_with { new(client, server, download, upload) }
  end
end
