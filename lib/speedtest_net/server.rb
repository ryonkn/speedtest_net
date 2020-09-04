# frozen_string_literal: true

require 'rexml/document'
require 'speedtest_net/config'
require 'speedtest_net/latency'
require 'speedtest_net/error'
require 'geo'

module SpeedtestNet
  class Server
    attr_reader :id, :url, :geo, :distance, :name, :country, :cc,
                :sponsor, :host
    attr_accessor :latency

    def initialize(id, url, geo, distance, server)
      @id = id
      @url = url
      @geo = geo
      @distance = distance
      @name = server['name']
      @country = server['country']
      @cc = server['cc']
      @sponsor = server['sponsor']
      @host = server['host']
      @latency = nil
    end

    def measure_latency
      @latency = Latency.measure(self)
    end

    class << self
      def list
        xml_servers = fetch_servers
        servers = xml_servers.map do |server|
          create_instance(server)
        end
        servers.sort_by { |s| [s.distance, s.id] }
      end

      def select_server(id = nil, exclude_server_ids = [])
        id.nil? ? best_server(exclude_server_ids) : pick_server(id)
      end

      private

      def best_server(exclude_server_ids)
        servers = list
        excluded_servers = servers.reject { |server| exclude_server_ids.include?(server.id) }
        closest_servers = excluded_servers.first(10)
        closest_servers.each(&:measure_latency)
        sorted_servers = closest_servers.sort_by do |s|
          [s.latency, s.distance, s.id]
        end
        sorted_servers.first
      end

      def pick_server(id)
        servers = list
        server = servers.find { |s| s.id == id }
        raise InvalidServerIdError if server.nil?

        server.measure_latency
        server
      end

      def create_instance(server)
        config = Config.fetch
        url = server['url2'] || server['url']

        geo = Geo.new(server['lat'].to_f, server['lon'].to_f)
        distance = geo.distance(config.client[:geo])

        new(server['id'].to_i, url, geo, distance, server)
      end

      def fetch_servers
        client = Curl::Easy.new('https://www.speedtest.net/speedtest-servers.php')
        client.follow_location = true
        client.perform

        raise HTTPDownloadError, 'Server lists download error' if client.response_code != 200

        xml = REXML::Document.new(client.body, ignore_whitespace_nodes: :all)
        xml.elements['settings/servers']
      end
    end
  end
end
