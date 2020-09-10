# frozen_string_literal: true

module SpeedtestNet
  module Formatter
    class Latency
      class << self
        def call(latency)
          format('%<latency>f millisecond', latency: latency * 1_000)
        end
      end
    end
  end
end
