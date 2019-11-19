# frozen_string_literal: true

require 'speedtest_net/version'
require 'speedtest_net/server'
require 'speedtest_net/download'
require 'speedtest_net/upload'
require 'speedtest_net/result'

module SpeedtestNet
  def self.run
    config = SpeedtestNet::Config.fetch
    server = SpeedtestNet::Server.best_server
    download = SpeedtestNet::Download.measure(server)
    upload = SpeedtestNet::Upload.measure(server)

    SpeedtestNet::Config.clear_cache
    SpeedtestNet::Result.new(config.client, server, download, upload)
  end

  def self.list_server
    SpeedtestNet::Server.list
  end
end
