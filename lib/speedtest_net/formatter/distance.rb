# frozen_string_literal: true

module SpeedtestNet
  module Formatter
    class Distance
      class << self
        def call(distance)
          format('%<distance>.3f kilometre', distance: (distance / 1_000).round(3))
        end
      end
    end
  end
end
