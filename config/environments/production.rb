require "active_support/core_ext/integer/time"

Rails.application.configure do
  config.cache_classes = true
  config.eager_load = true
  config.consider_all_requests_local       = false
  config.public_file_server.enabled = ENV["RAILS_SERVE_STATIC_FILES"].present?
  config.active_storage.service = :local
  config.log_tags = [ :request_id ]
  config.action_mailer.perform_caching = false
  config.i18n.fallbacks = true
  config.active_support.report_deprecations = false
  config.log_formatter = ::Logger::Formatter.new
  config.force_ssl = ENV["FORCE_SSL"] == "true"
  config.log_level = :debug
  config.logger = ActiveSupport::Logger.new(STDOUT)

  config.active_record.dump_schema_after_migration = false
end
