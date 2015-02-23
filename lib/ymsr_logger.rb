class YmsrLogger
  class << self
    attr_accessor :logger

    def tweet(message)
      logger.post(:tweet, mesage: message)
    end
  end
end
