# This file is used by Rack-based servers to start the application.

require_relative 'config/environment'

# run Rails.application
use Rails::Rack::LogTailer
use Rails::Rack::Static
run ActionController::Dispatcher.new