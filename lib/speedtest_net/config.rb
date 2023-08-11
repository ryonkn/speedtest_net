# frozen_string_literal: true

require 'rexml/document'
require 'speedtest_net/client'
require 'speedtest_net/error'
require 'speedtest_net/geo'

module SpeedtestNet
  class Config
    private_class_method :new
    attr_reader :client, :server, :download, :upload, :latency

    @instance_cache = nil

    def initialize(client, server, download, upload, latency)
      @client = client
      @server = server
      @download = download
      @upload = upload
      @latency = latency
    end

    class << self
      def fetch
        return @instance_cache unless @instance_cache.nil?

        elements = fetch_config
        @instance_cache = create_instance(elements)
      end

      def clear_cache
        @instance_cache = nil
      end

      private

      def create_instance(elements)
        new(
          client_config(elements['settings/client']),
          server_config(elements['settings/server-config']),
          download_config(elements['settings/download']),
          upload_config(elements['settings/upload']),
          latency_config(elements['settings/latency'])
        )
      end

      def fetch_config
        client = Typhoeus::Request.new('https://www.speedtest.net/speedtest-config.php', followlocation: true)
        client.run

        raise HTTPDownloadError, 'Config download error' if client.response.code != 200

        xml = REXML::Document.new(client.response.body, ignore_whitespace_nodes: :all)
        xml.elements
      end

      def client_config(elements)
        Client.new(elements['ip'], elements['isp'], Geo.new(elements['lat'].to_f, elements['lon'].to_f))
      end

      def server_config(elements)
        {
          threadcount: elements['threadcount'].to_i,
          ignoreids: elements['ignoreids'].split(',').map(&:to_i).sort,
          notonmap: elements['notonmap'].split(',').map(&:to_i).sort,
          forcepingid: elements['forcepingid'],
          preferredserverid: elements['preferredserverid']
        }
      end

      def download_config(elements)
        {
          testlength: elements['testlength'].to_i,
          initialtest: elements['initialtest'],
          mintestsize: elements['mintestsize'],
          threadsperurl: elements['threadsperurl'].to_i
        }
      end

      def upload_config(elements)
        {
          testlength: elements['testlength'].to_i,
          initialtest: elements['initialtest'].to_i,
          mintestsize: elements['mintestsize'],
          threads: elements['threads'].to_i,
          maxchunksize: elements['maxchunksize'],
          maxchunkcount: elements['maxchunkcount'].to_i,
          threadsperurl: elements['threadsperurl'].to_i
        }
      end

      def latency_config(elements)
        {
          testlength: elements['testlenght'].to_i,
          waittime: elements['waittime'].to_i,
          timeout: elements['timeout'].to_i
        }
      end
    end
  end
end
