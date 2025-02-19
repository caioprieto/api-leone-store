require_relative "boot"
require "rails/all"

Bundler.require(*Rails.groups)

# Para usar no DESENVOLVIMENTO
ENV['REDIS_URL'] = 'redis://redis:6379/0'

# Para usar no DEPLOY
# ENV['REDIS_URL'] = 'redis://red-culnp1pu0jms73bp6h8g:6379'

module ApiLeoneStore
  class Application < Rails::Application
    config.load_defaults 7.0
    config.api_only = true
    config.active_storage.analyzers = []
    config.active_job.queue_adapter = :sidekiq

    # Comentar quando subir para produção
    config.hosts.clear if Rails.env.production?

    config.hosts << "api-leone-store-1.onrender.com"
    config.hosts << "api-leone-store.onrender.com"

    config.hosts << "localhost"
    config.hosts << "localhost:3000"
  end
end
