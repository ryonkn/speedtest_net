# frozen_string_literal: true

require 'securerandom'
require 'timeout'
require 'typhoeus'
require 'speedtest_net/http_timeout'
require 'speedtest_net/measure_result'

module SpeedtestNet
  class Upload
    SIZE = [250_000, 500_000, 1_000_000, 2_000_000, 4_000_000, 8_000_000,
            12_000_000, 17_000_000, 24_000_000, 32_000_000].freeze

    class << self
      def measure(server, timeout: HTTP_TIMEOUT) # rubocop:disable Metrics/MethodLength
        config = Config.fetch
        concurrent_number = config.upload[:threadsperurl]

        results = []
        begin
          Timeout.timeout(timeout) do
            SIZE.each do |size|
              urls = create_urls(server, concurrent_number)
              results << multi_uploader(urls, size)
            end
          end
        rescue Timeout::Error # rubocop:disable Lint/SuppressedException
        end
        MeasureResult.new(results)
      end

      private

      def create_urls(server, number)
        Array.new(number) do
          random = SecureRandom.urlsafe_base64
          "#{server.url}?x=#{random}"
        end
      end

      def multi_uploader(urls, size)
        responses = []
        Typhoeus::Config.user_agent = USER_AGENT
        hydra = Typhoeus::Hydra.new
        urls.each do |url|
          request = Typhoeus::Request.new(url, method: :post, body: "content1:#{'A' * size}")
          request.on_complete { |response| responses << response }
          hydra.queue(request)
        end
        hydra.run
        responses.sum(&:speed_upload) * 8
      end
    end
  end
end
