# frozen_string_literal: true

module SpeedtestNet
  class Client
    attr_reader :ip, :isp, :geo

    def initialize(ip, isp, geo)
      @ip = ip
      @isp = isp
      @geo = geo
    end
  end
end
