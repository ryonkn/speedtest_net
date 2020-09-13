# frozen_string_literal: true

require 'curb'
require 'securerandom'
require 'speedtest_net/calculate_speed'

module SpeedtestNet
  class Upload
    SIZE = [250_000, 500_000, 1_000_000, 2_000_000, 4_000_000, 8_000_000,
            12_000_000, 17_000_000, 24_000_000, 32_000_000].freeze

    def initialize(results)
      @results = results
    end

    def calculate
      CalculateSpeed.call(@results)
    end

    class << self
      def measure(server, timeout: 120) # rubocop:disable Metrics/MethodLength
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
        new(results)
      end

      private

      def create_urls(server, number)
        number.times.map do
          random = SecureRandom.urlsafe_base64
          "#{server.url}?x=#{random}"
        end
      end

      def multi_uploader(urls, size) # rubocop:disable Metrics/MethodLength
        responses = []
        content = 'A' * size
        multi = Curl::Multi.new
        urls.each do |url|
          client = Curl::Easy.new(url)
          client.headers['User-Agent'] = USER_AGENT
          client.http_post(Curl::PostField.content('content1', content))
          client.on_complete { |data| responses << data }
          multi.add(client)
        end
        multi.perform
        responses.map(&:upload_speed).sum * 8
      end
    end
  end
end
