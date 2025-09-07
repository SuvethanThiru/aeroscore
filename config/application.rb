# config/application.rb
require_relative "boot"

require "rails/all"

Bundler.require(*Rails.groups)

module Aeroscore
  class Application < Rails::Application
    config.load_defaults 7.0
    
    # Configuration for the application
    config.api_only = false
    
    # Fix timezone deprecation warning
    config.active_support.to_time_preserves_timezone = :zone

    # CORS configuration for API
    config.middleware.insert_before 0, Rack::Cors do
      allow do
        origins '*'
        resource '*',
          headers: :any,
          methods: [:get, :post, :put, :patch, :delete, :options, :head]
      end
    end
    
    # Webpacker configuration
    config.assets.paths << Rails.root.join('app', 'javascript', 'stylesheets')
  end
end