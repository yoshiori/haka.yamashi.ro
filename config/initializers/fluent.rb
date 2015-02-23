require "fluent-logger"


YmsrLogger.logger = if Rails.env.production?
                      Fluent::Logger::FluentLogger.new(
                        :ymsr,
                        host: "localhost",
                        port: 24224
                      )
                    else
                      Fluent::Logger::NullLogger.new
                    end
