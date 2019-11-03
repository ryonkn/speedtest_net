# frozen_string_literal: true

require 'curb'
require 'securerandom'

module SpeedtestNet
  class Upload
    SIZE = [250_000, 500_000, 1_000_000, 2_000_000, 4_000_000, 8_000_000,
            12_000_000, 17_000_000, 24_000_000, 32_000_000].freeze

    class << self
      def measure(server)
        config = SpeedtestNet::Config.fetch
        concurrent_number = config.upload[:threadsperurl]

        results = SIZE.map do |size|
          urls = create_urls(server, concurrent_number)
          multi_uploader(urls, size)
        end
        calculate_results(results)
      end

      private

      def create_urls(server, number)
        number.times.map do
          random = SecureRandom.urlsafe_base64
          "#{server.url}?x=#{random}"
        end
      end

      def multi_uploader(urls, size)
        responses = []
        content = 'A' * size
        url_fields = urls.map do |url|
          { url: url, post_fields: { 'content1' => content } }
        end
        Curl::Multi.post(url_fields) do |curl|
          responses << curl
        end
        responses.map(&:upload_speed).sum * 8
      end

      def calculate_results(results)
        count = results.count
        faster = count - (count * 0.1).round
        slower = (count * 0.3).round
        target_results = results[slower...faster]
        target_results.sum / target_results.count
      end
    end
  end
end
