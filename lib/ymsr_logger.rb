class YmsrLogger
  class << self
    attr_accessor :logger

    def tweet(message)
      logger.post(:tweet, message: message)
    end
  end
end
