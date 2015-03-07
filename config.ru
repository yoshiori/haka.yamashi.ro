# This file is used by Rack-based servers to start the application.
require "rack-health"
require "rack/revision"
require "grape/rabl"

use Rack::Health
use Rack::Revision
use Rack::Config do |env|
  env["api.tilt.root"] = ::File.expand_path("../app/views", __FILE__)
end

require ::File.expand_path("../config/environment", __FILE__)
run Rails.application
