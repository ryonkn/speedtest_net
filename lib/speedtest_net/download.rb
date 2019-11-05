# frozen_string_literal: true

require 'curb'
require 'securerandom'

module SpeedtestNet
  class Download
    FILES = %w[random350x350.jpg random500x500.jpg random1000x1000.jpg
               random1500x1500.jpg random2000x2000.jpg random3000x3000.jpg
               random3500x3500.jpg random4000x4000.jpg].freeze

    class << self
      def measure(server)
        config = SpeedtestNet::Config.fetch
        concurrent_number = config.download[:threadsperurl]

        results = FILES.map do |file|
          urls = create_urls(server, file, concurrent_number)
          multi_downloader(urls)
        end
        calculate_results(results)
      end

      private

      def create_urls(server, file, number)
        base_url = Pathname(server.url).dirname.to_s
        number.times.map do
          random = SecureRandom.urlsafe_base64
          "#{base_url}/#{file}?x=#{random}"
        end
      end

      def multi_downloader(urls)
        responses = []
        multi = Curl::Multi.new
        urls.each do |url|
          client = Curl::Easy.new(url)
          client.on_complete { |data| responses << data }
          multi.add(client)
        end
        multi.perform
        responses.map(&:download_speed).sum * 8
      end

      def calculate_results(results)
        sorted_results = results.sort
        count = sorted_results.count
        faster = count - (count * 0.1).round
        slower = (count * 0.3).round
        target_results = sorted_results[slower...faster]
        target_results.sum / target_results.count
      end
    end
  end
end
