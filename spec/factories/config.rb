# frozen_string_literal: true

FactoryBot.define do # rubocop:disable Metrics/BlockLength
  factory :config, class: 'SpeedtestNet::Config' do # rubocop:disable Metrics/BlockLength
    client do
      {
        ip: '127.0.0.1',
        isp: 'example isp',
        geo: SpeedtestNet::Geo.new(0.0, 0.0)
      }
    end

    server do
      {
        threadcount: 1,
        ignoreids: [1, 2, 3],
        notonmap: [4, 5, 6],
        forcepingid: '',
        preferredserverid: ''
      }
    end

    download do
      {
        testlength: 1,
        initialtest: '250K',
        mintestsize: '250K',
        threadsperurl: 1
      }
    end

    upload do
      {
        testlength: 1,
        initialtest: 1,
        mintestsize: '32K',
        threads: 1,
        maxchunksize: '512K',
        maxchunkcount: 1,
        threadsperurl: 1
      }
    end

    latency do
      {
        testlength: 0,
        waittime: 50,
        timeout: 20
      }
    end

    initialize_with do
      SpeedtestNet::Config.send(:new, client, server, download, upload, latency)
    end
  end
end
