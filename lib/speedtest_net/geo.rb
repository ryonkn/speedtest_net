# frozen_string_literal: true

module SpeedtestNet
  class Geo
    RADIAN_PER_DEGREE = Math::PI / 180
    EARTH_RADIUS = 6_371_000

    def initialize(lat, long)
      @lat = lat
      @long = long
    end

    def distance(other) # rubocop:disable Metrics/AbcSize
      a = (Math.sin(radian_lat) * Math.sin(other.radian_lat)) +
          (Math.cos(radian_lat) * Math.cos(other.radian_lat) * Math.cos(radian_long - other.radian_long))

      Math.acos(a) * EARTH_RADIUS
    end

    def radian_lat
      @lat * RADIAN_PER_DEGREE
    end

    def radian_long
      @long * RADIAN_PER_DEGREE
    end
  end
end
