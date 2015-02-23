require "fluent-logger"

Fluent::Logger::FluentLogger.open(nil, host: "localhost", port: 24224)
