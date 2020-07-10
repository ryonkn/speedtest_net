# frozen_string_literal: true

require 'speedtest_net/version'
require 'speedtest_net/user_agent'
require 'speedtest_net/server'
require 'speedtest_net/download'
require 'speedtest_net/upload'
require 'speedtest_net/result'

module SpeedtestNet
  def self.run(id = nil)
    config = SpeedtestNet::Config.fetch
    server = SpeedtestNet::Server.select_server(id)
    download_results = SpeedtestNet::Download.measure(server)
    upload_results = SpeedtestNet::Upload.measure(server)

    SpeedtestNet::Config.clear_cache
    SpeedtestNet::Result.new(config.client, server, download_results,
                             upload_results)
  end

  def self.list_server
    SpeedtestNet::Server.list
  end
end
