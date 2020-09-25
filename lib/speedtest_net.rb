# frozen_string_literal: true

require 'speedtest_net/version'
require 'speedtest_net/user_agent'
require 'speedtest_net/server'
require 'speedtest_net/download'
require 'speedtest_net/upload'
require 'speedtest_net/result'
require 'speedtest_net/http_timeout'

module SpeedtestNet
  def self.run(id = nil, exclude_server_ids: [], timeout: HTTP_TIMEOUT)
    config = Config.fetch
    server = Server.select_server(id, exclude_server_ids)
    download_results = Download.measure(server, timeout: timeout)
    upload_results = Upload.measure(server, timeout: timeout)

    Config.clear_cache
    Result.new(config.client, server, download_results, upload_results)
  end

  def self.list_server
    Server.list
  end
end
