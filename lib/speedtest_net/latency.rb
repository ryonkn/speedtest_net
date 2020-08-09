# frozen_string_literal: true

require 'typhoeus'
require 'securerandom'
require 'pathname'

module SpeedtestNet
  class Latency
    DEFAULT_TEST_LENGTH = 10
    DEFAULT_LATENCY = 3600.0

    class << self
      def measure(server)
        config = Config.fetch
        test_length = test_length(config)
        timeout = config.latency[:timeout]

        latencies = test_length.times.map do
          latency_url = latency_url(server)
          measure_latency(latency_url, timeout)
        end
        server.latency = latencies.min
      end

      private

      def latency_url(server)
        random = SecureRandom.urlsafe_base64
        Pathname(server.url).dirname.to_s + "/latency.txt?x=#{random}"
      end

      def test_length(config)
        config_latency = config.latency[:testlength]
        config_latency.positive? ? config_latency : DEFAULT_TEST_LENGTH
      end

      def measure_latency(url, timeout)
        Typhoeus::Config.user_agent = SpeedtestNet::USER_AGENT
        client = Typhoeus::Request.new(url, followlocation: true,
                                            timeout: timeout)
        client.run

        return DEFAULT_LATENCY if client.response.response_code != 200

        client.response.total_time
      end
    end
  end
end
