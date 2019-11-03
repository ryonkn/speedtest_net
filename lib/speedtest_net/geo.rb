# frozen_string_literal: true

module SpeedtestNet
  class Geo
    RADIUS_PER_DEGREE = Math::PI / 180
    RADIUS_METER = 6_371_000

    attr_reader :lat, :long

    def initialize(lat, long)
      @lat = lat
      @long = long
    end

    def distance(other) # rubocop:disable Metrics/AbcSize
      delta_lat = (@lat - other.lat) * RADIUS_PER_DEGREE
      delta_long = (@long - other.long) * RADIUS_PER_DEGREE

      lat_radius = @lat * RADIUS_PER_DEGREE
      other_lat_radius = other.lat * RADIUS_PER_DEGREE

      a = Math.sin(delta_lat / 2)**2 +
          Math.cos(lat_radius) *
          Math.cos(other_lat_radius) *
          Math.sin(delta_long / 2)**2

      Math.atan2(Math.sqrt(a), Math.sqrt(1 - a)) * 2 * RADIUS_METER
    end
  end
end
