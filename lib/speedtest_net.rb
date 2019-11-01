# frozen_string_literal: true

require 'speedtest_net/version'
require 'Speedtest_net/run'
require 'Speedtest_net/server'

module SpeedtestNet
  def self.run
    SpeedtestNet::Run.call
  end

  def self.list_server
    SpeedtestNet::Server.list
  end
end
