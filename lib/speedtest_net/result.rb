# frozen_string_literal: true

require 'speedtest_net/formatter/distance'
require 'speedtest_net/formatter/latency'
require 'speedtest_net/formatter/speed'

module SpeedtestNet
  class Result
    attr_reader :client, :server

    def initialize(client, server, download_result, upload_result)
      @client = client
      @server = server
      @download_result = download_result
      @upload_result = upload_result
    end

    def download
      @download_result.calculate
    end

    def pretty_download
      Formatter::Speed.call(download)
    end

    def upload
      @upload_result.calculate
    end

    def pretty_upload
      Formatter::Speed.call(upload)
    end

    def latency
      @server.latency
    end

    def pretty_latency
      Formatter::Latency.call(latency)
    end

    def distance
      @server.distance
    end

    def pretty_distance
      Formatter::Distance.call(distance)
    end
  end
end
