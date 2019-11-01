# frozen_string_literal: true

require 'geo_point'
require 'rexml/document'
require 'speedtest_net/config'
require 'speedtest_net/latency'
require 'speedtest_net/error'

module SpeedtestNet
  class Server
    attr_reader :id, :url, :geo_point, :distance, :name, :country, :cc,
                :sponsor, :host
    attr_accessor :latency

    def initialize(id, url, geo_point, distance, server)
      @id = id
      @url = url
      @geo_point = geo_point
      @distance = distance
      @name = server['name']
      @country = server['country']
      @cc = server['cc']
      @sponsor = server['sponsor']
      @host = server['host']
      @latency = nil
    end

    def measure_latency
      @latency = SpeedtestNet::Latency.measure(self)
    end

    class << self
      def list
        xml_servers = fetch_servers
        servers = xml_servers.map do |server|
          create_instance(server)
        end
        servers.sort { |a, b| a.distance <=> b.distance }
      end

      def best_server
        servers = list
        closest_servers = servers.first(10)
        closest_servers.each(&:measure_latency)
        sorted_servers = closest_servers.sort { |a, b| a.latency <=> b.latency }
        sorted_servers.first
      end

      private

      def create_instance(server)
        config = SpeedtestNet::Config.fetch
        url = server['url2'] || server['url']

        geo_point = GeoPoint.new(server['lat'].to_f, server['lon'].to_f)
        distance = geo_point.distance_to(config.client[:geo_point])

        new(server['id'].to_i, url, geo_point, distance, server)
      end

      def fetch_servers
        client = Curl::Easy.new('https://www.speedtest.net/speedtest-servers.php')
        client.follow_location = true
        client.perform

        if client.response_code != 200
          raise HTTPDownloadError, 'Server lists download error'
        end

        xml = REXML::Document.new(client.body, ignore_whitespace_nodes: :all)
        xml.elements['settings/servers']
      end
    end
  end
end
