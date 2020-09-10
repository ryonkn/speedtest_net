# frozen_string_literal: true

require 'speedtest_net/formatter/distance'
require 'speedtest_net/formatter/latency'
require 'speedtest_net/formatter/speed'

module SpeedtestNet
  class Result
    UNITS = %w[bps Kbps Mbps Gbps Tbps].freeze

    attr_reader :client, :server

    def initialize(client, server, download, upload)
      @client = client
      @server = server
      @download = download
      @upload = upload
    end

    def download
      @download.calculate
    end

    def pretty_download
      Formatter::Speed.call(download)
    end

    def upload
      @upload.calculate
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

    private

    def pretty_format(speed)
      i = 0
      while speed > 1000
        speed /= 1000
        i += 1
      end
      format('%<speed>.2f %<unit>s', speed: speed, unit: UNITS[i])
    end
  end
end
