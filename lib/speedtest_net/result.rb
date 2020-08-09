# frozen_string_literal: true

require 'speedtest_net/calculate_speed'

module SpeedtestNet
  class Result
    UNITS = %w[bps Kbps Mbps Gbps Tbps].freeze

    attr_reader :client, :server, :download_results, :upload_results

    def initialize(client, server, download_results, upload_results)
      @client = client
      @server = server
      @download_results = download_results
      @upload_results = upload_results
    end

    def download
      CalculateSpeed.call(@download_results)
    end

    def pretty_download
      pretty_format(download)
    end

    def upload
      CalculateSpeed.call(@upload_results)
    end

    def pretty_upload
      pretty_format(upload)
    end

    def latency
      @server.latency
    end

    def pretty_latency
      format('%<latency>f millisecond', latency: latency * 1_000)
    end

    def distance
      @server.distance
    end

    def pretty_distance
      format('%<distance>.3f kilometre', distance: (distance / 1_000).round(3))
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
