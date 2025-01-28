require_relative "boot"

require "rails/all"

Bundler.require(*Rails.groups)

module ApiLeoneStore
  class Application < Rails::Application
    config.load_defaults 7.0
    config.api_only = true
    config.active_storage.analyzers = []

    # Comentar quando subir para produção
    config.hosts.clear if Rails.env.production?

    config.hosts << "api-leone-store-1.onrender.com"
    config.hosts << "api-leone-store.onrender.com"

    config.hosts << "localhost"
    config.hosts << "localhost:3000"
  end
end
