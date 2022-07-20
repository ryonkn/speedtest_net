# frozen_string_literal: true

module SpeedtestNet
  class MeasureResult
    def initialize(results = [])
      @results = results.select { |result| result.instance_of?(Integer) || result.instance_of?(Float) }
    end

    def calculate
      return 0.0 if @results.size.zero?

      # Fastest 10% and slowest 30% of results are then discarded
      # See: https://support.ookla.com/hc/en-us/articles/234575828-What-is-the-test-flow-and-methodology-for-the-Speedtest-
      sorted_results = @results.sort
      count = sorted_results.size

      faster = count - (count * 0.1).round # fastest 10%
      slower = (count * 0.3).round # slowest 30%
      target_results = sorted_results[slower...faster]

      # The remaining result are averaged together to determine
      # the final result
      target_results.sum.to_f / target_results.count
    end
  end
end
