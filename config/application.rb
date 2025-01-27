require_relative "boot"

require "rails/all"

Bundler.require(*Rails.groups)

module ApiLeoneStore
  class Application < Rails::Application
    config.load_defaults 7.0
    config.api_only = true
    config.active_storage.analyzers = []

    config.hosts << "api-leone-store-1.onrender.com"
    config.hosts << "api-leone-store.onrender.com"
  end
end
