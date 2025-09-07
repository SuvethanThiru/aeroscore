# config/environments/production.rb
Rails.application.configure do
  config.cache_classes = true
  config.eager_load = true
  config.consider_all_requests_local = false
  config.public_file_server.enabled = ENV['RAILS_SERVE_STATIC_FILES'].present?
  
  config.assets.compile = false
  config.active_storage.variant_processor = :mini_magick
  config.log_level = :info
  config.log_tags = [ :request_id ]
  
  config.cache_store = :mem_cache_store
  config.active_job.queue_adapter = :resque
  config.active_record.dump_schema_after_migration = false
  
  # Force all access to the app over SSL
  config.force_ssl = true
  
  # Webpacker production settings
  config.webpacker.compile = false
  config.webpacker.check_yarn_integrity = false
end