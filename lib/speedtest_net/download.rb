# frozen_string_literal: true

require 'curb'
require 'securerandom'
require 'pathname'
require 'speedtest_net/calculate_speed'
require 'speedtest_net/http_timeout'

module SpeedtestNet
  class Download
    FILES = %w[random350x350.jpg random500x500.jpg random1000x1000.jpg
               random1500x1500.jpg random2000x2000.jpg random3000x3000.jpg
               random3500x3500.jpg random4000x4000.jpg].freeze

    def initialize(results)
      @results = results
    end

    def calculate
      CalculateSpeed.call(@results)
    end

    class << self
      def measure(server, timeout: HTTP_TIMEOUT) # rubocop:disable Metrics/MethodLength
        config = Config.fetch
        concurrent_number = config.download[:threadsperurl]

        results = []
        begin
          Timeout.timeout(timeout) do
            FILES.each do |file|
              urls = create_urls(server, file, concurrent_number)
              results << multi_downloader(urls)
            end
          end
        rescue Timeout::Error # rubocop:disable Lint/SuppressedException
        end
        new(results)
      end

      private

      def create_urls(server, file, number)
        base_url = Pathname(server.url).dirname.to_s
        Array.new(number) do
          random = SecureRandom.urlsafe_base64
          "#{base_url}/#{file}?x=#{random}"
        end
      end

      def multi_downloader(urls)
        responses = []
        multi = Curl::Multi.new
        urls.each do |url|
          client = Curl::Easy.new(url)
          client.headers['User-Agent'] = USER_AGENT
          client.on_complete { |data| responses << data }
          multi.add(client)
        end
        multi.perform
        responses.sum(&:download_speed) * 8
      end
    end
  end
end
