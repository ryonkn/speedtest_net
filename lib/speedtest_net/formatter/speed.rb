# frozen_string_literal: true

module SpeedtestNet
  module Formatter
    class Speed
      UNITS = %w[bps Kbps Mbps Gbps Tbps].freeze

      class << self
        def call(speed)
          i = 0
          while speed >= 1000
            speed /= 1000
            i += 1
          end
          format('%<speed>.2f %<unit>s', speed: speed, unit: UNITS[i])
        end
      end
    end
  end
end
