# This file is used by Rack-based servers to start the application.
use Rack::Health
use Rack::Revision

require ::File.expand_path('../config/environment', __FILE__)
run Rails.application
