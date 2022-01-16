# frozen_string_literal: true

module SpeedtestNet
  class CalculateSpeed
    class << self
      # Fastest 10% and slowest 30% of results are then discarded
      # See: https://support.ookla.com/hc/en-us/articles/234575828-What-is-the-test-flow-and-methodology-for-the-Speedtest-
      def call(results)
        sorted_results = sorted_nemric_results(results)
        count = sorted_results.count

        return 0.0 if count.zero?

        faster = count - (count * 0.1).round # fastest 10%
        slower = (count * 0.3).round # slowest 30%
        target_results = sorted_results[slower...faster].to_a

        # The remaining result are averaged together to determine
        # the final result
        target_results.sum.to_f / target_results.count
      end

      private

      def sorted_nemric_results(results)
        numeric_results = results.select { |result| result.is_a? Numeric }
        numeric_results.sort
      end
    end
  end
end
