# frozen_string_literal: true

module SpeedtestNet
  class Error < StandardError; end

  class HTTPDownloadError < Error; end

  class InvalidServerIdError < Error; end
end
