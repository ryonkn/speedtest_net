# frozen_string_literal: true

require 'speedtest_net/version'
require 'speedtest_net/run'
require 'speedtest_net/server'

module SpeedtestNet
  def self.run
    SpeedtestNet::Run.call
  end

  def self.list_server
    SpeedtestNet::Server.list
  end
end
