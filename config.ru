# This file is used by Rack-based servers to start the application.
use Rack::Health

require ::File.expand_path('../config/environment', __FILE__)
run Rails.application
